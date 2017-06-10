//
//  CCSwiftTests.swift
//  CCSwiftTests
//
//  Created by 渡部郷太 on 6/6/17.
//  Copyright © 2017 watanabe kyota. All rights reserved.
//

import XCTest
@testable import CCSwift

class CCSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBalance() {
        let privateApi = PrivateApi(apiKey: apiKey, secretKey: secretKey)
        
        let balanceTest = self.expectation(description: "balanceTest")
        privateApi.balance() { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            balanceTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testNewOrder() {
        let privateApi = PrivateApi(apiKey: apiKey, secretKey: secretKey)
        let order = BuyBtcJpyOrder(rate: 200000, amount: CurrencyPair.btcJpy.orderUnit)
        
        let minOrderTest = self.expectation(description: "minOrderTest")
        privateApi.newOrder(order: order) { (err, res) in
            XCTAssertNotNil(err)
            print(err!)
            minOrderTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testTicker() {
        let tickerTest = self.expectation(description: "tickerTest")
        PublicApi.ticker() { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            tickerTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPublicTrades() {
        let tradesTest = self.expectation(description: "tradesTest")
        PublicApi.publicTrades(offset: 0) { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            tradesTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testOrderBook() {
        let orderBookTest = self.expectation(description: "orderBookTest")
        PublicApi.orderBook(limit: 10) { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            orderBookTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testOrderRate() {
        let orderRateBuyTest = self.expectation(description: "orderRateBuyTest")
        PublicApi.orderRate(currencyPair: CurrencyPair.btcJpy, orderType: OrderType.buy) { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            orderRateBuyTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
        let orderRateSellTest = self.expectation(description: "orderRateSellTest")
        PublicApi.orderRate(currencyPair: CurrencyPair.btcJpy, orderType: OrderType.buy) { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            orderRateSellTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUnsettledOrderList() {
        let privateApi = PrivateApi(apiKey: apiKey, secretKey: secretKey)
        
        let orderListTest = self.expectation(description: "orderListTest")
        privateApi.unsettledOrderList() { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            orderListTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testCancelOrder() {
        let privateApi = PrivateApi(apiKey: apiKey, secretKey: secretKey)
        
        let cancelOrderTest = self.expectation(description: "cancelOrderTest")
        privateApi.cancelOrder(orderId: "ddd") { (err, res) in
            XCTAssertNil(err)
            XCTAssertNotNil(res)
            print(res!)
            cancelOrderTest.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}
