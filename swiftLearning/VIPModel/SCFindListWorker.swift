//
//  SCFindListWorker.swift
//  Scripts
//
//  Created by 陈小贝 on 2022/11/28.
//

import Foundation

class SCFindListWorker {
    func requestForFindListData(cid: Int, pageIndex: Int, pageSize: Int, complete: @escaping (DataModel) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            if let model = MockData.parserToObject() {
                complete(model.data!)
            }else {
                print("出错了")
            }
        }
    }
    
    /// 点赞或取消
    /// likeType:  类型，1:点赞,2:取消点赞
    func requestForBtnLike(id: Int ,likeType: Int, complete: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            complete()
        }
    }
}
