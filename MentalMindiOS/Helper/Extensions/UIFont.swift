//
//  UIFont.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func gotham(ofSize: CGFloat, weight: FontStyles) -> UIFont {
        return UIFont(name: "Gotham-\(weight)", size: ofSize)!
    }
    
    class func montserrat(ofSize: CGFloat, weight: MontserratStyles) -> UIFont {
        return UIFont(name: weight.rawValue, size: ofSize)!
    }
    
    class func jura(ofSize: CGFloat, weight: JuraStyles) -> UIFont {
        return UIFont(name: weight.rawValue, size: ofSize)!
    }
}
