//
//  SCFindListModels.swift
//  Scripts
//
//  Created by 陈小贝 on 2022/11/28.
//

import Foundation

enum SCFindListModels {
    
    enum FetchLists {
        struct Request {
            var cid: Int
            var pageIndex: Int
            var pageSize: Int
            var isMore: Bool
        }
        
        struct Response {
            var dataSource: [ListModel]
            var count: Int
            var isMore: Bool
        }
        
        struct ViewModel {
            struct FindListModel {
                var isLike: Int?
                var id: Int?
                var avatar: String = ""
                var nickname: String = ""
                var content: String = ""
                var likeCount: Int = 0
                var images: [String] = []
            }
            var dataSource: [FindListModel]
            var count: Int
            var isMore: Bool
        }
    }
    
    enum FetchLike {
        struct Request {
            var id: Int
            //likeType:  类型，1:点赞,2:取消点赞
            var likeType: Int
        }
        struct Response {}
    }
}
