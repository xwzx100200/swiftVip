//
//  XCFindListWorkerTest.swift
//  swiftLearningTests
//
//  Created by 陈小贝 on 2022/12/1.
//

import XCTest
@testable import swiftLearning

class XCFindListWorkerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWorkerData() {
        let sut: XCTestExpectation = expectation(description: "testAsync")
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            if let model = MockData.parserToObject() {
                print("异步请求完成！")
                sut.fulfill()
            }else {
                print("出错了")
            }
        }
        waitForExpectations(timeout: 5) { error in
            print("超时了")
        }
    }
    
}
