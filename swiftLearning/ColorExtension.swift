//
//  ColorExtension.swift
//  swiftLearning
//
//  Created by 陈小贝 on 2022/11/29.
//

import UIKit

extension UIColor {
    public convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    public convenience init(rgba: UInt32) {
        self.init(red: CGFloat((rgba & 0xFF000000) >> 24) / 255.0,
                    green:CGFloat((rgba & 0xFF0000) >> 16) / 255.0,
                    blue:CGFloat((rgba & 0xFF00) >> 8) / 255.0,
                    alpha:CGFloat(rgba & 0xFF) / 255.0)
    }
    public convenience init(rgb: UInt32, alpha: CGFloat = 1) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                    green:CGFloat((rgb & 0xFF00) >> 8) / 255.0,
                    blue:CGFloat(rgb & 0xFF) / 255.0,
                    alpha:alpha)
    }
    ///替换透明度
    public func asAlpha(_ value: CGFloat) -> UIColor {
        return self.withAlphaComponent(value)
    }
    public class func rgb(_ rgb: UInt32, alpha: CGFloat = 1) -> UIColor {
        return .init(rgb: rgb, alpha: alpha)
    }
    public class func rgb(_ r: Int, _ g: Int, _ b: Int, alpha: CGFloat = 1) -> UIColor {
        return .init(r: r, g: g, b: b, a: alpha)
    }
    public class func rgba(_ rgba: UInt32) -> UIColor {
        return .init(rgba: rgba)
    }
}
