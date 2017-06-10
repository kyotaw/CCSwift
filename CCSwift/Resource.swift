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
                self.processResponse(err: nil, res: data, callback: callback)
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
                    self.processResponse(err: nil, res: data, callback: callback)
                }
        }
    }
    
    func delete(
        url: String,
        headers: Dictionary<String, String>,
        callback: @escaping CCCallback) {
        
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default
            )) {
                response in
                
                switch response.result {
                case .failure(_):
                    callback(CCError(errorCode: .connectionError), nil)
                    return
                case .success:
                    let data = JSON(response.result.value! as AnyObject)
                    self.processResponse(err: nil, res: data, callback: callback)
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
    
    fileprivate func processResponse(err: CCError? , res: JSON?, callback: CCCallback) {
        if err != nil {
            callback(err, nil)
            return
        }
        
        if let success = res?.dictionary?["success"]?.bool {
            if success {
                callback(nil, res)
            }
        }
        
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
    
    static let endPointUrl = "https://coincheck.com/api"
}
