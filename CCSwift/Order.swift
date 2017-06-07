//
//  Order.swift
//  CCSwift
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import Foundation


public enum OrderType : String {
    case buy = "buy"
    case sell = "sell"
    case marketBuy = "market_buy"
    case marketSell = "market_sell"
    case leverageBuy = "leverage_buy"
    case leverageSell = "leverage_sell"
    case closeLong = "close_long"
    case closeShort = "close_short"
}


public protocol Order {
    var currencyPairParameter: String { get }
    var orderTypeParameter: String { get }
    var rateParameter: String? { get }
    var amountParameter: String? { get }
    var marketBuyAmountParameter: String? { get }
    var positionIdParameter: String? { get }
    var stopLossRateParameter: String? { get }
}


public class CCOrder : Order {
    internal init(currencyPair: CurrencyPair, orderType: OrderType) {
        self.currencyPair = currencyPair
        self.orderType = orderType
    }
    public var currencyPairParameter: String {
        return self.currencyPair.rawValue
    }
    
    public var orderTypeParameter: String {
        return self.orderType.rawValue
    }
    
    public var rateParameter: String? {
        return nil
    }
    
    public var amountParameter: String? {
        return nil
    }
    
    public var marketBuyAmountParameter: String? {
        return nil
    }
    
    public var positionIdParameter: String? {
        return nil
    }
    
    public var stopLossRateParameter: String? {
        return nil
    }
    
    public let currencyPair: CurrencyPair
    public let orderType: OrderType
}

public class BtcJpyOrder : CCOrder {
    public init(orderType: OrderType, rate: Double, amount: Double) {
        self.rate = rate
        self.amount = amount
        super.init(currencyPair: .btcJpy, orderType: orderType)
    }
    
    override public var rateParameter: String? {
        return self.rate.description
    }
    
    override public var amountParameter: String? {
        get {
            let str = self.amount.description
            let pos = str.characters.enumerated().filter{ (index, c) in c == "."}.first?.0
            guard let p = pos else {
                return str
            }
            var end = p + 9
            let len = str.characters.count
            if len < end {
                end = len
            }
            return str.substring(to: str.index(str.startIndex, offsetBy: end))
        }
    }
    
    public let rate: Double
    public let amount: Double
    
}


public class BuyBtcJpyOrder : BtcJpyOrder {
    public init(rate: Int, amount: Double) {
        super.init(orderType: .buy, rate: Double(rate), amount: amount)
    }
}


public class SellBtcJpyOrder : BtcJpyOrder {
    public init(rate: Int, amount: Double) {
        super.init(orderType: .sell, rate: Double(rate), amount: amount)
    }
}
