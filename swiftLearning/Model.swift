//
//  Model.swift
//  swiftLearning
//
//  Created by 陈小贝 on 2022/11/29.
//

import HandyJSON

class BaseModel: HandyJSON {
    var requestId: String?
    var code: Int?
    var msg: String?
    var data: DataModel?
    
    required init(){} // 必须实现一个空的初始化方法
}

class DataModel: HandyJSON {
    var count: Int?
    var pageIndex: Int?
    var pageSize: Int?
    var list: [ListModel] = []
    
    required init(){} // 必须实现一个空的初始化方法
}

class ListModel: HandyJSON {
    var isLike: Int?
    var id: Int?
    var mem: ListMemberModel?
    var content: String = ""
    var likeCount: Int = 0
    var images: [String] = []
    
    required init(){} // 必须实现一个空的初始化方法
}

class ListMemberModel: HandyJSON {
    var avatar: String = ""
    var nickname: String = ""
    
    required init(){} // 必须实现一个空的初始化方法
}
