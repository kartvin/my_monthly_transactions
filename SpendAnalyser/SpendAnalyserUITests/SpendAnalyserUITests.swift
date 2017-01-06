//
//  SpendAnalyserUITests.swift
//  SpendAnalyserUITests
//
//  Created by Karthik Kumaravel on 1/5/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import XCTest

class SpendAnalyserUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSpendAnalyserListView() {
        let app = XCUIApplication()
        sleep(5)
        let spendAnalyserButton = app.tabBars.buttons["Spend analyser"]
        XCTAssertTrue(spendAnalyserButton.exists)
        spendAnalyserButton.tap()
    }
    
    func testTransactionListView() {
        let app = XCUIApplication()
        sleep(5)
        let spendAnalyserButton = app.tabBars.buttons["Transactions"]
        XCTAssertTrue(spendAnalyserButton.exists)
        spendAnalyserButton.tap()
    }
    
}
