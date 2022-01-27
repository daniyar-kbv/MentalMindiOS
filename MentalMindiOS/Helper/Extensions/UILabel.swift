//
//  UILabel.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import UIKit

extension UILabel {
    func applyGradientWith(startColor: UIColor, endColor: UIColor) {
        var startColorRed:CGFloat = 0
        var startColorGreen:CGFloat = 0
        var startColorBlue:CGFloat = 0
        var startAlpha:CGFloat = 0

        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
            return
        }

        var endColorRed:CGFloat = 0
        var endColorGreen:CGFloat = 0
        var endColorBlue:CGFloat = 0
        var endAlpha:CGFloat = 0

        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
            return
        }

        let gradientText = self.text ?? ""

        let name: NSAttributedString.Key = NSAttributedString.Key.font
        let textSize: CGSize = gradientText.size(withAttributes: [name: self.font])
        let width:CGFloat = textSize.width
        let height:CGFloat = textSize.height

        UIGraphicsBeginImageContext(CGSize(width: width, height: height))

        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }

        UIGraphicsPushContext(context)

        let glossGradient:CGGradient?
        let rgbColorspace:CGColorSpace?
        let num_locations:size_t = 2
        let locations:[CGFloat] = [ 0.0, 1.0 ]
        let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
        rgbColorspace = CGColorSpaceCreateDeviceRGB()
        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
        let topCenter = CGPoint.zero
        let bottomCenter = CGPoint(x: 0, y: textSize.height)
        context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)

        UIGraphicsPopContext()

        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return
        }

        UIGraphicsEndImageContext()

        self.textColor = UIColor(patternImage: gradientImage)
    }
    
    func applyGradientWith(colors: [UIColor] = [UIColor(hex: "#1E3F62"), UIColor(hex: "#4A90D5")], locations: [CGFloat] = [0.0, 1.0], direction: Direction = .topToBottom) {
        let gradientText = self.text ?? ""

        let name: NSAttributedString.Key = NSAttributedString.Key.font
        let textSize: CGSize = gradientText.size(withAttributes: [name: self.font as Any])
        let width: CGFloat = textSize.width
        let height: CGFloat = textSize.height

        UIGraphicsBeginImageContext(CGSize(width: width, height: height))

        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return
        }

        UIGraphicsPushContext(context)
        
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map({ $0.cgColor }) as CFArray, locations: locations)
        
        var startPoint: CGPoint
        var endPoint: CGPoint
        
        switch direction {
        case .topToBottom:
            startPoint = CGPoint(x: textSize.width / 2, y: 0.0)
            endPoint = CGPoint(x: textSize.width / 2, y: textSize.height)
        case .bottomToTop:
            startPoint = CGPoint(x: textSize.width / 2, y: textSize.height)
            endPoint = CGPoint(x: textSize.width / 2, y: 0.0)
        case .leftToRight:
            startPoint = CGPoint(x: 0.0, y: textSize.height / 2)
            endPoint = CGPoint(x: textSize.width, y: textSize.height / 2)
        case .rightToLeft:
            startPoint = CGPoint(x: textSize.width, y: textSize.height / 2)
            endPoint = CGPoint(x: 0.0, y: textSize.height / 2)
        case .leftTopToRightBottom:
            startPoint = CGPoint(x: 0.0, y: 0.0)
            endPoint = CGPoint(x: textSize.width, y: textSize.height)
        case .rightTopToLeftBottom:
            startPoint = CGPoint(x: textSize.width, y: 0)
            endPoint = CGPoint(x: 0.0, y: textSize.height)
        }
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.drawsBeforeStartLocation)

        UIGraphicsPopContext()

        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return
        }

        UIGraphicsEndImageContext()

        self.textColor = UIColor(patternImage: gradientImage)
    }
}
