//
//  PrivateApi.swift
//  CCSwift
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation

public struct ApiKeys {
    internal init(apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
    }
    
    internal let apiKey: String
    internal let secretKey: String
}


public class PrivateApi {
    
    public init(apiKey: String, secretKey: String, nonce: NonceProtocol?=nil) {
        self.keys = ApiKeys(apiKey: apiKey, secretKey: secretKey)
        if let n = nonce {
            self.nonce = n
        } else {
            self.nonce = TimeNonce()
        }
    }
    
    public func balance(_ callback: @escaping CCCallback) {
        PrivateResource().balance(apiKeys: self.keys, nonce: self.nonce, callback: callback)
    }
    
    public func newOrder(order: Order, callback: @escaping CCCallback) {
        PrivateResource().newOrder(order: order, apiKeys: self.keys, nonce: self.nonce, callback: callback)
    }
    
    public func unsettledOrderList(callback: @escaping CCCallback) {
        PrivateResource().unsettledOrderList(apiKeys: self.keys, nonce: self.nonce, callback: callback)
    }
    
    public var apiKey: String {
        get { return self.keys.apiKey }
    }
    
    public var secretKey: String {
        get { return self.keys.secretKey }
    }

    public var nonceValue: Int64 {
        get { return self.nonce.currentValue }
    }
    
    fileprivate let keys: ApiKeys
    fileprivate let nonce: NonceProtocol!
}
