//
//  SCSetting.swift
//  Scripts
//
//  Created by wangtuo on 2022/8/22.
//

import UIKit

/// 公共配置
struct SCSetting {
    /// 客服微信ID
    static let customerServiceWexinId = "abcdefg"
    
    struct Color {
        /// 主色调
        static let main = UIColor(rgb: 0x5C55F1)
        /// 辅色调
        static let sub = UIColor(rgb: 0xF7B440)
    }
    
    struct FontColor {
        ///字体主色调
        static let main = UIColor(rgb: 0x333333)
        
        ///字体主色调
        static let dark = UIColor(rgb: 0x666666)

        ///浅色调
        static let light = UIColor(rgb: 0x999999)
    }
    
    static func font(light size:CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Light", size: size) ?? .systemFont(ofSize: size)
    }
    static func font(regular size:CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    static func font(medium size:CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    static func font(bold size:CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Semibold", size: size) ?? .systemFont(ofSize: size)
    }
}
extension UIColor {
    static var main: UIColor {
        return SCSetting.Color.main
    }
    static var sub: UIColor {
        return SCSetting.Color.sub
    }
    static var font222222: UIColor {
        return .rgb(0x222222)
    }
    static var fontMain: UIColor {
        return SCSetting.FontColor.main
    }
    static var fontDark: UIColor {
        return SCSetting.FontColor.dark
    }
    static var fontLight: UIColor {
        return SCSetting.FontColor.light
    }
//    static func rgb(_ rgb: UInt32) -> UIColor {
//        return .init(rgb: rgb)
//    }
//    static func rgb(_ rgb: UInt32, alpha: CGFloat) -> UIColor {
//        return .init(rgb: rgb, alpha: alpha)
//    }
}
extension UIFont {
    static func light(_ size:CGFloat) -> UIFont {
        return SCSetting.font(light: size)
    }
    static func regular(_ size:CGFloat) -> UIFont {
        return SCSetting.font(regular: size)
    }
    static func medium(_ size:CGFloat) -> UIFont {
        return SCSetting.font(medium: size)
    }
    static func bold(_ size:CGFloat) -> UIFont {
        return SCSetting.font(bold: size)
    }
}
