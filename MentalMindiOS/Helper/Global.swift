//
//  Global.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit


class Global {

    //MARK: - Safe area
    static let keyWindow = AppShared.sharedInstance.keyWindow
    
    class func safeAreaTop() -> CGFloat {
        var window = keyWindow
        if #available(iOS 11.0, *), let keyWindow = window {
            var area = keyWindow.safeAreaInsets.top
            if  area == 0 { area = 20 }
            return area
        } else {
            return 0
        }
    }

    class func safeAreaBottom() -> CGFloat{
        var window = keyWindow
        if window == nil{
            window = AppShared.sharedInstance.keyWindow
        }
        if #available(iOS 11.0, *), let keyWindow = window{
            var area = keyWindow.safeAreaInsets.bottom
            if area == 0 { area = 20 }
            return area
        } else {
            return 20
        }
    }
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct StaticSize {
    static private let proportion: CGFloat = 414 / 896
    static let buttonHeight = size(45)
    static let tabBarHeight = Global.safeAreaBottom() + size(60)
    static let calendarCellSize = (ScreenSize.SCREEN_WIDTH - StaticSize.size(34)) / 7
    static let levelViewHeight = size(271)
    
    static func size(_ size: CGFloat) -> CGFloat {
        return (ScreenSize.SCREEN_HEIGHT * proportion) / 375 * size
    }
}
