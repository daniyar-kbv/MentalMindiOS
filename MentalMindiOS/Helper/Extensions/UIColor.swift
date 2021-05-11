//
//  UIColor.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
//  MARK: Colors
    
    static let customTextBlack = UIColor(hex: "#333333")
    static let customTextGray = UIColor(hex: "#82858C")
    static let customLightGreen = UIColor(hex: "#6BD9BF")
    static let customLoaderGray = UIColor(hex: "#DFDFDF")
    static let customBlue = UIColor(hex: "#50A6F5")
    static let customGreen = UIColor(hex: "#52E59E")
    static let customTextLightBlue = UIColor(hex: "#82BFE7")
    static let customTextBlue = UIColor(hex: "#219AEB")
    static let customGray = UIColor(hex: "#C7C7CC")
    static let customRed = UIColor(hex: "#FF6464")
    
//  MARK: Methods
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if (hex.hasPrefix("#")) {
            scanner.currentIndex = String.Index(utf16Offset: 1, in: hex)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
