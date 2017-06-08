//
//  Resource.swift
//  CCSwift
//
//  Created by 渡部郷太 on 2/19/17.
//
//

import Foundation

import CryptoSwift
import Alamofire
import SwiftyJSON


class Resource {
    
    func get(
        _ url: String,
        params: Dictionary<String, String>=[:],
        headers: Dictionary<String, String>=[:],
        callback: @escaping CCCallback) {
        
        let queryUrl = Resource.addQueryParameters(url: url, params: params)
        Alamofire.request(queryUrl, method: .get, headers: headers).responseJSON() { response in
            switch response.result {
            case .failure(_):
                callback(CCError(errorCode: .connectionError), nil)
                return
            case .success:
                let data = JSON(response.result.value! as AnyObject)
                print(data)
                
                callback(nil, data)
            }
        }
    }
    
    func post(
        url: String,
        params: Dictionary<String, String>,
        headers: Dictionary<String, String>,
        callback: @escaping CCCallback) {
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default
            )) {
                response in
                
                switch response.result {
                case .failure(_):
                    callback(CCError(errorCode: .connectionError), nil)
                    return
                case .success:
                    let data = JSON(response.result.value! as AnyObject)
                    if let success = data.dictionary?["success"]?.bool {
                        if success {
                            callback(nil, data)
                        }
                    }
                    // error
                    if let errorMsg = data.dictionary?["error"]?.string {
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
    
    static func addQueryParameters(url: String, params: [String:String]) -> String {
        guard params.count > 0 else {
            return url
        }
        var queryUrl = url + "?"
        for (key, val) in params {
            queryUrl += "\(key)=\(val)&"
        }
        queryUrl.characters.removeLast()
        return queryUrl
    }
    
    static let endPointUrl = "https://coincheck.com/api"
}
