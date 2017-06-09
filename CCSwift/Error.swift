//
//  Error.swift
//  CCSwift
//
//  Created by 渡部郷太 on 2/11/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//


public enum CCErrorCode: String, Error {
    case nonceExceedLimit = "nonceExceedLimit"
    case cryptionError = "cryptionError"
    case connectionError = "connectionError"
    
    case invalidAuthentication = "invalid authentication"
    case badRequest = "bad_request"
    
    case unknownError = "unknownError"
}


public struct CCError {
    init(errorCode: CCErrorCode = .unknownError, message: String = "") {
        self.errorCode = errorCode
        self.message = message
    }
    public let errorCode: CCErrorCode
    public let message: String
}
