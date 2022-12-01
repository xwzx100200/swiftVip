//
//  Reqeust.swift
//  swiftLearning
//
//  Created by 陈小贝 on 2022/11/29.
//

import Foundation

class Request {
    
    
}


class MockData {

    static let dataStr: String = "{\"requestId\":\"63ca4b39-34d5-4045-82da-b3e481ec76a0\",\"code\":200,\"msg\":\"获取成功\",\"data\":{\"count\":5,\"pageIndex\":1,\"pageSize\":10,\"list\":[{\"id\":4,\"mem\":{\"avatar\":\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/gjijux.jpeg\",\"nickname\":\"qym\"},\"content\":\"⏰这个处理HTTP请求的方法必须是公共方法（首字母要大写），并且不能有参数，不能有返回值，若非如此，可能会发生Panic。\",\"images\":[\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/io7gwe.webp\"],\"likeCount\":0,\"isLike\":2},{\"id\":5,\"mem\":{\"avatar\":\"http://talking-static.gdjunyuekj.com/static/uploadfile/member/avatar/f3/1/f35b8b9f42c32653bb216fa8624a9ecc.jpeg\",\"nickname\":\"zjf\"},\"content\":\"根据上图我们可以知道，这个app.Handles就是ControllerRegister，再来看看ControllerRegister的AddAuto方法：\",\"images\":[\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/io7gwe.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/pc30d8.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/x8epbi.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/kc7nre.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/yef3a4.webp\"],\"likeCount\":0,\"isLike\":2},{\"id\":3,\"mem\":{\"avatar\":\"http://talking-static.gdjunyuekj.com/static/uploadfile/member/avatar/f3/1/f35b8b9f42c32653bb216fa8624a9ecc.jpeg\",\"nickname\":\"zjf\"},\"content\":\"Beego的路由设计灵感是sinatra，刚开始并不支持自动路由，项目的每一个路由都需要开发者配置。\",\"images\":[],\"likeCount\":0,\"isLike\":2},{\"id\":1,\"mem\":{\"avatar\":\"http://talking-static.gdjunyuekj.com/static/uploadfile/member/avatar/f3/1/f35b8b9f42c32653bb216fa8624a9ecc.jpeg\",\"nickname\":\"zjf\"},\"content\":\"电影有时是一种好玩的东西，你们觉得呢\",\"images\":[\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/bxql8y.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/0om1lj.webp\"],\"likeCount\":0,\"isLike\":2},{\"id\":2,\"mem\":{\"avatar\":\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/gjijux.jpeg\",\"nickname\":\"qym\"},\"content\":\"go-zero 是一个集成了各种工程实践的 web 和 rpc 框架。通过弹性设计保障了大并发服务端的稳定性，并经受了充分的实战检验（好未来-晓黑板）\",\"images\":[\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/pc30d8.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/x8epbi.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/kc7nre.webp\",\"http://talking-static.gdjunyuekj.com/static/uploadfile/avatar/yef3a4.webp\"],\"likeCount\":1,\"isLike\":2}]}}"
    
    static func parserToObject() -> BaseModel? {
        if let model: BaseModel = BaseModel.deserialize(from: dataStr){
           return model
        }else{
            print("解析失败")
            return nil
        }
    }
}
