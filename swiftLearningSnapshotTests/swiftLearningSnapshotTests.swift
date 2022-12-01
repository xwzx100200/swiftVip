//
//  swiftLearningSnapshotTests.swift
//  swiftLearningSnapshotTests
//
//  Created by 陈小贝 on 2022/11/29.
//

import FBSnapshotTestCase
@testable import swiftLearning

class swiftLearningSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHomeController() {
        let vc = ViewController()
        FBSnapshotVerifyView(vc.view)
    }
    
    func testListController() {
        let vc: SCFindListViewController = SCFindListViewController()
        vc.index = 0
        vc.cid = 1
        FBSnapshotVerifyView(vc.view)
    }
}
