//
//  PublicResource.swift
//  CCSwift
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import SwiftyJSON
import Alamofire


internal class PublicResource : Resource {
    
    func ticker(callback: @escaping CCCallback) {
        let url = Resource.endPointUrl + "/ticker"
        self.get(url, callback: callback)
    }
    
    func publicTrades(offset: Int, callback: @escaping CCCallback) {
        let url = Resource.endPointUrl + "/trades"
        self.get(url, params: ["offset": offset.description], callback: callback)
    }
    
    func orderBook(limit: Int, callback: @escaping CCCallback) {
        let url = Resource.endPointUrl + "/order_books"
        self.get(url, params: ["limit": limit.description], callback: callback)
    }
    
    func orderRate(currencyPair: CurrencyPair, orderType: OrderType, callback: @escaping CCCallback) {
        let url = Resource.endPointUrl + "/exchange/orders/rate"
        let params = [
            "order_type": orderType.rawValue,
            "pair": currencyPair.rawValue
        ]
        self.get(url, params: params, callback: callback)
    }
    
}
