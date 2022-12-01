//
//  XCFindListInteractorTest.swift
//  swiftLearningTests
//
//  Created by 陈小贝 on 2022/11/29.
//

import XCTest
@testable import swiftLearning

class XCFindListInteractorTest: XCTestCase {
    var sut: SCFindListInteractor!
    var expect: XCTestExpectation!
    override func setUp() {
        super.setUp()
        sut = SCFindListInteractor()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShowFindListData() {
        let worker = SCFindListWorkerTest()
        sut.worker = worker
        let presenter = SCFindListPresenterTest()
        sut.presenter = presenter
        let request: SCFindListModels.FetchLists.Request = SCFindListModels.FetchLists.Request(cid: 1, pageIndex: 1, pageSize: 10, isMore: false)
        
        sut.getFindListData(request: request)
        
        XCTAssert(presenter.presenterCalled, "present方法失败");
        
    }
    
    func testLikeData() {
        let worker = SCFindListWorkerTest()
        sut.worker = worker
        let presenter = SCFindListPresenterTest2()
        sut.presenter = presenter
        let model = MockData.parserToObject()!
        sut.dataSource = model.data?.list ?? []
        
        let request: SCFindListModels.FetchLike.Request = SCFindListModels.FetchLike.Request(id: 1, likeType: 1)
        sut.requestFindListLike(request: request)
        XCTAssert(presenter.presenterCalled, "present方法失败");
    }
    
    
    class SCFindListPresenterTest2: FindListPresenterDataProtocol {
        var presenterCalled = false
        func presentListData(response: SCFindListModels.FetchLists.Response) {
            let list = response.dataSource
            for item in list {
                if item.id == 1 {
                    presenterCalled = true
                    XCTAssert(item.isLike == 1, "点赞成功")
                    XCTAssert(item.likeCount == 1, "点赞成功")
                }
            }
        }
    }
    
    class SCFindListPresenterTest: FindListPresenterDataProtocol {
        var presenterCalled = false
        func presentListData(response: SCFindListModels.FetchLists.Response) {
            presenterCalled = true
            XCTAssert(!response.isMore, "非上拉加载更多")
            XCTAssert(response.dataSource.count == 5, "list数量有误")
            XCTAssert(response.count == 5, "list总数量有误")
        }
    }
    
    
    class SCFindListWorkerTest: SCFindListWorker {
        override func requestForFindListData(cid: Int, pageIndex: Int, pageSize: Int, complete: @escaping (DataModel) -> Void) {
            let model = MockData.parserToObject()!
            complete(model.data!)
            /*DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                let model = MockData.parserToObject()!
                complete(model.data!)
            }*/
        }
        
        override func requestForBtnLike(id: Int ,likeType: Int, complete: @escaping ()-> Void) {
            complete()
        }
    }
}
