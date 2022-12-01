//
//  AppDelegate.swift
//  swiftLearning
//
//  Created by 陈小贝 on 2022/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let naviVC = UINavigationController.init(rootViewController: ViewController())
        naviVC.navigationBar.isTranslucent = false
        naviVC.navigationBar.tintColor = UIColor(rgb: 0x333333)
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
        return true
    }
}

