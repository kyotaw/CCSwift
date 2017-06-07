//
//  Currency.swift
//  CCSwift
//
//  Created by 渡部郷太 on 2/11/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//


public enum CurrencyPair : String {
    case btcJpy = "btc_jpy"
    
    public var orderUnit: Double {
        switch self {
        case .btcJpy: return 0.00000001
        }
    }
}
