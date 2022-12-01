//
//  swiftLearningUITests.swift
//  swiftLearningUITests
//
//  Created by 陈小贝 on 2022/11/29.
//

import XCTest

class swiftLearningUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false;
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHomeController() {
        let app = XCUIApplication()
        let btn: XCUIElement = app.buttons.element(matching: .button, identifier: "goListBtn")
        XCTAssert(btn.exists, "定位按钮")
        XCTAssert(btn.label == "列表页", "按钮标题")
        btn.tap()
        
        let titleElement = app.navigationBars["VIP架构"]
        XCTAssert(titleElement.exists, "跳转成功")

    }
    
    func testFindListControllerBack() {
        let app = XCUIApplication()
        let btn: XCUIElement = app.buttons.element(matching: .button, identifier: "goListBtn")
        btn.tap()
        
        let backBtn = app.buttons["首页"]
        XCTAssert(backBtn.exists, "返回按钮")
        backBtn.tap()
        
        let titleElement = app.navigationBars["首页"]
        XCTAssert(titleElement.exists, "返回成功")
        
    }
    
    func testFindListControllerCell() {
        let app = XCUIApplication()
        let btn: XCUIElement = app.buttons.element(matching: .button, identifier: "goListBtn")
        btn.tap()
        sleep(1)
        
        let cell = app.cells.element(matching: .cell, identifier: "SCFindListCellIdentifier-0")
        XCTAssert(cell.exists, "第一个cell")
        
        cell.tap()
        
        let titleElement = app.navigationBars["详情页"]
        XCTAssert(titleElement.exists, "详情页挑转成功")
    }
    
}
