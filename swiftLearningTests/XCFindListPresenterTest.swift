//
//  XCFindListPresenterTest.swift
//  swiftLearningTests
//
//  Created by 陈小贝 on 2022/11/29.
//

import XCTest
@testable import swiftLearning

class XCFindListPresenterTest: XCTestCase {
    
    var sut: SCFindListPresenter!
    override func setUp() {
        super.setUp()
        sut = SCFindListPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFormListData() {
        let controller = SCFindListControllerTest()
        sut.viewController = controller
        let list = MockData.parserToObject()?.data?.list ?? []
        
        let response = SCFindListModels.FetchLists.Response(dataSource: list, count: list.count,isMore: false)
        sut.presentListData(response: response)
        XCTAssert(controller.presenterCalled, "方法没有回调")
    }
    
    class SCFindListControllerTest: SCFindShowListProtocol {
        var presenterCalled = false
        func showFindList(_ with: SCFindListModels.FetchLists.ViewModel) {
            presenterCalled = true
            XCTAssert(!with.isMore, "非加载更多")
            XCTAssert(with.count == 5, "数量错误")
            for item in with.dataSource {
                XCTAssert(!item.avatar.isEmpty , "没赋值正确")
                XCTAssert(!item.nickname.isEmpty, "没赋值正确")
            }
        }
    }

}
