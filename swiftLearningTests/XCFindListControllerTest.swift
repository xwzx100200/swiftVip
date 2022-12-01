//
//  XCFindListControllerTest.swift
//  swiftLearningTests
//
//  Created by 陈小贝 on 2022/11/29.
//

import XCTest
@testable import swiftLearning

class XCFindListControllerTest: XCTestCase {
    
    var sut: SCFindListViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        sut = SCFindListViewController()
        sut.index = 0
        sut.cid = 1
        window = UIWindow()
    }
    
    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
    }
    
    func loadView() {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
    
    func testControllerDidLoad() {
        let interator = SCFindListInteractorTest()
        sut.interactor = interator
        
        loadView()
        sut.viewDidLoad()
        
        XCTAssert(interator.interactorCalled, "函数未被调用")
    }
    
    class SCFindListInteractorTest: FindListDataProtocol {
        var interactorCalled = false
        func getFindListData(request: SCFindListModels.FetchLists.Request) {
            interactorCalled = true
            XCTAssert(!request.isMore, "加载错误")
            XCTAssert(request.cid == 1, "加载错误")
            XCTAssert(request.pageSize == 10, "加载错误")
            XCTAssert(request.pageIndex == 1, "加载错误")
        }
        
        func requestFindListLike(request: SCFindListModels.FetchLike.Request) {}
    }
    
    
    class SCFindListTableView: UITableView {
        
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    func testTableViewReload() {
        let tableview = SCFindListTableView()
        sut.tableView = tableview
        let vm = SCFindListModels.FetchLists.ViewModel(dataSource: [], count: 0, isMore: false)
        sut.showFindList(vm)
        XCTAssert(tableview.reloadDataCalled, "tableview没有reload")
    }
    
    func testTableviewSection() {
        let tableview = SCFindListTableView()
        sut.tableView = tableview
        let sectionCount = sut.numberOfSections(in: tableview)
        XCTAssert(sectionCount == 1, "tableview的section错误")
    }
    
    func testTableviewRow() {
        let tableview = SCFindListTableView()
        sut.tableView = tableview
        let dataArr = [SCFindListModels.FetchLists.ViewModel.FindListModel(isLike: 1, id: 1, avatar: "", nickname: "", content: "", likeCount: 0, images: [])]
        sut.dataSource = dataArr
        
        let row = sut.tableView(tableview, numberOfRowsInSection: 0)
        XCTAssert(row == dataArr.count, "tableview的row错误")
    }
    
    func testTableviewCell() {
        let tableview = SCFindListTableView()
        tableview.register(SCFindListCell.self, forCellReuseIdentifier: "SCFindListCellIdentifier")
        sut.tableView = tableview
        let dataArr = [SCFindListModels.FetchLists.ViewModel.FindListModel(isLike: 2, id: 1, avatar: "http://talking-static.gdjunyuekj.com/static/uploadfile/member/avatar/f3/1/f35b8b9f42c32653bb216fa8624a9ecc.jpeg", nickname: "zjf", content: "电影有时是一种好玩的东西，你们觉得呢", likeCount: 0, images: [])]
        sut.dataSource = dataArr
        
        let cell: SCFindListCell = sut.tableView(tableview, cellForRowAt: IndexPath(row: 0, section: 0)) as! SCFindListCell
        let name: String = cell.headerNameLabel.text!
        let content: String = cell.contentLabel.text!
        XCTAssert( name == "zjf", "tableview的cell错误")
        XCTAssert(content == "电影有时是一种好玩的东西，你们觉得呢", "tableview的cell错误")
    }
}
