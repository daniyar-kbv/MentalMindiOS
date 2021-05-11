//
//  UIBezirePat.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

public extension UIBezierPath {
    static var figurePath: UIBezierPath {
        let picturePath = UIBezierPath()
        picturePath.move(to: CGPoint(x: 0, y: 512))
        picturePath.addLine(to: CGPoint(x: 512, y: 512))
        picturePath.addLine(to: CGPoint(x: 512, y: 0))
        picturePath.addLine(to: CGPoint(x: 0, y: 0))
        picturePath.addLine(to: CGPoint(x: 0, y: 512))
        picturePath.close()
        return picturePath
    }
}
