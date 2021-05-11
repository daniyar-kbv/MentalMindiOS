//
//  NSObject.swift
//  GOALSTER
//
//  Created by Daniyar on 9/2/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

public extension NSObject{
    class var nameOfClass: String{
        return (NSStringFromClass(self).components(separatedBy: ".") as [String]).last!
    }
 
    var nameOfClass: String{
        return (NSStringFromClass(type(of: self)).components(separatedBy: ".") as [String]).last!
    }
}
