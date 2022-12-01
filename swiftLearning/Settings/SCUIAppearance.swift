//
//  SCUIAppearance.swift
//  Scripts
//
//  Created by wangtuo on 2022/8/20.
//

import UIKit
import UICreate

class SCUIAppearance {
    static var statusBarHeight: CGFloat { return UIApplication.shared.statusBarFrame.size.height }
    static var navigationHeight: CGFloat { return statusBarHeight + 44 }
    ///配置公共UI
    class func load(){
        let screenWidth = UIScreen.main.bounds.size.width
        //设置导航栏背景颜色和字体
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundImage = UIImage.create(color: .white, size: CGSize(width: screenWidth, height: navigationHeight))
            appearance.backgroundImageContentMode = .scaleAspectFill
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .white
            appearance.backgroundEffect = nil
            appearance.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x333333)]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance

        } else {
            var backgroundImage = UIImage.create(color: .white, size: CGSize(width: screenWidth, height: navigationHeight))
            backgroundImage = backgroundImage.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
            UINavigationBar.appearance().setBackgroundImage(backgroundImage, for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            UINavigationBar.appearance().shadowImage = UIImage()

            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x333333)]
        }
        UINavigationBar.appearance().tintColor = UIColor(rgb: 0x333333)
        UINavigationBar.appearance().isTranslucent = false

        //设置tabbar背景颜色
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        } 
    }
}

extension UCSetting where TargetType: UISwitch {
    static var main: Self {
        return .group(.tint(.rgb(0xD8D8D8)), .tint(thumb: .white), .tint(on: .main))
    }
}

extension UCSetting where TargetType: UIButton {
    static var main: Self {
        return .group(.font(.bold(15)), .color(.white), .bg(.main), .corner(5), .height(44), .bg(.rgb(0xeeeeee), for: .disabled))
    }
}

extension UCSetting where TargetType: UIImageView {
    static func image(_ named: String, _ color: UInt32) -> Self {
        return .image(UIImage(named: named)?.byTint(.rgb(color)))
    }
}
extension UCSetting where TargetType: UIButton {
    static func image(_ named: String, _ color: UInt32, for state: UIControl.State = .normal) -> Self {
        return .image(UIImage(named: named)?.byTint(.rgb(color)), for: state)
    }
    static func bg(_ named: String, _ color: UInt32, for state: UIControl.State = .normal) -> Self {
        return .bg(UIImage(named: named)?.byTint(.rgb(color)), for: state)
    }
}

