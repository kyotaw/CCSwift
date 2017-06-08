//
//  PrivateResource.swift
//  CCSwift
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

import SwiftyJSON
import CryptoSwift
import Alamofire


private class URLtoEncoding : URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let URL = Foundation.URL(string: PrivateResource.endPointUrl)!
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        return request
    }
}

private func makeBodyString(_ params: Dictionary<String, String>) -> String {
    let encoding = Alamofire.JSONEncoding.default
    do {
        let request = try encoding.encode(URLtoEncoding(), with: params)
        return NSString(data: request.httpBody!, encoding:String.Encoding.utf8.rawValue)! as String
    } catch {
        return ""
    }
}


class PrivateResource : Resource {
    
    func balance(apiKeys: ApiKeys, nonce: NonceProtocol, callback: @escaping CCCallback) {
        do {
            let url = Resource.endPointUrl + "/accounts/balance"
            let params = Dictionary<String, String>()
            let headers = try self.makeHeaders(params: params, url: url, nonce: nonce, apiKeys: apiKeys)
            self.get(url, headers: headers, callback: callback)
        } catch CCErrorCode.cryptionError {
            callback(CCError(errorCode: .cryptionError), nil)
        } catch {
            callback(CCError(), nil)
        }
    }
    
    func orders(order: Order, apiKeys: ApiKeys, nonce: NonceProtocol, callback: @escaping CCCallback) {
        do {
            let url = Resource.endPointUrl + "/exchange/orders"
            var params = [
                "pair": order.currencyPairParameter,
                "order_type": order.orderTypeParameter
            ]
            if let rate = order.rateParameter {
                params["rate"] = rate
            }
            if let amount = order.amountParameter {
                params["amount"] = amount
            }
            if let marketBuyAmount = order.marketBuyAmountParameter {
                params["market_buy_amount"] = marketBuyAmount
            }
            if let positionId = order.positionIdParameter {
                params["position_id"] = positionId
            }
            if let stopLossRate = order.stopLossRateParameter {
                params["stop_loss_rate"] = stopLossRate
            }
            
            let headers = try self.makeHeaders(params: params, url: url, nonce: nonce, apiKeys: apiKeys)
            self.post(url: url, params: params, headers: headers, callback: callback)
        } catch CCErrorCode.cryptionError {
            callback(CCError(errorCode: .cryptionError), nil)
        } catch {
            callback(CCError(), nil)
        }
    }
    
    fileprivate func makeHeaders(params: Dictionary<String, String>, url: String, nonce: NonceProtocol, apiKeys: ApiKeys) throws -> Dictionary<String, String> {
        
        var jsonBody = ""
        if params.count > 0 {
            jsonBody = makeBodyString(params)
        }
        
        let nonceValue = try nonce.getNonce()
        
        let contents = nonceValue + url + jsonBody
        
        let hmac: Array<UInt8> = try HMAC(key: apiKeys.secretKey.utf8.map({$0}), variant: .sha256).authenticate(contents.utf8.map({$0}))
        
        let headers = [
            "ACCESS-KEY": apiKeys.apiKey,
            "ACCESS-NONCE": nonceValue,
            "ACCESS-SIGNATURE": hmac.toHexString()
        ]

        return headers
    }
    
    internal override func get(_ url: String, headers: Dictionary<String, String>, callback: @escaping (_ err: CCError?, _ res: JSON?) -> Void) {
        super.get(url, headers: headers) { (err, res) in
         
            if let success = res?.dictionary?["success"]?.bool {
                if success {
                    callback(nil, res)
                    return
                }
            }
            
            // error
            if let errorMsg = res?.dictionary?["error"]?.string {
                if let errorCode = CCErrorCode(rawValue: errorMsg) {
                    callback(CCError(errorCode: errorCode, message: errorMsg), nil)
                } else {
                    callback(CCError(message: errorMsg), nil)
                }
                return
            }
            callback(CCError(), nil)
            
        }
    }
    
}
