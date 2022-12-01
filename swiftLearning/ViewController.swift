//
//  ViewController.swift
//  swiftLearning
//
//  Created by 陈小贝 on 2022/11/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        //let model = MockData.parserToObject()
        
        let btn: UIButton = UIButton(frame: CGRect(x: 50, y: 150, width: 100, height: 50))
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        btn.backgroundColor = UIColor.red
        btn.setTitle("列表页", for: .normal)
        btn.accessibilityIdentifier = "goListBtn"
        view.addSubview(btn)
        
        test()
    }
    
    @objc func clickBtn() {
        let vc: SCFindListViewController = SCFindListViewController()
        vc.index = 0
        vc.cid = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func test() {
        let str: String = "阿凡达了解阿斯利#康都放假啦可是当减肥了#卡就收到了咖啡#机阿斯顿发多少"
        let c: Character = str[str.startIndex]
        print(c)
        
        for c in str.indices {
            print(c)
            print(str[c])
        }
        
        // 截取第二个到第10个
        let startIndex = str.index(str.startIndex, offsetBy: 1)
        let endIndex = str.index(str.startIndex, offsetBy: 9)
        let substr: Substring = str[startIndex...endIndex]  // SubString类型，不是String类型
        let realStr: String = String(substr)
        print(substr)
        print(realStr)
        
        //根据#分割字符串
        let arr: [String] = str.components(separatedBy: "#")
        let arr2: [Substring] = str.split(separator: "#")
        for sub in arr {
            print(sub)
        }
        
        for sub2 in arr2 {
            print(sub2)
        }
        
        let strArr = ["阿凡达了解阿斯利","康都放假啦可是当减肥了","机阿斯顿发多少"]
        let joinStr: String = strArr.joined(separator: "@")
        print(joinStr)
    }
}
