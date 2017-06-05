//
//  Board.swift
//  CCSwift
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//


enum QuoteSide {
    case bid
    case ask
}


struct Quote {
    let side: QuoteSide
    let price: Double
    let size: Double
}


struct Board {
    let midPrice: Double
    let bids: [Quote]
    let asks: [Quote]
}
