//
//  UIView.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
            return constraint
        }
        return nil
    }

    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        let firstItemMatch = constraint.firstItem as? UIView == self && constraint.firstAttribute == layoutAttribute
        let secondItemMatch = constraint.secondItem as? UIView == self && constraint.secondAttribute == layoutAttribute
        return firstItemMatch || secondItemMatch
    }
    
    func addSubViews(_ views: [UIView]){
        for view in views{
            addSubview(view)
        }
    }
    
    func mask(path: UIBezierPath){
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        let scale = self.layer.bounds.width / path.bounds.width
        mask.transform = CATransform3DMakeScale(scale, scale, 1)
        layer.mask = mask
    }
    
    func viewContainingController() -> UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
        case leftTopToRightBottom
        case rightTopToLeftBottom
    }
    
    func addGradientBackground(colors: [UIColor] = [UIColor(hex: "#1E3F62"), UIColor(hex: "#4A90D5")], locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom) {
        
        let gradientLayer = CAGradientLayer()
        var cgColors: [CGColor] = []
        for color in colors {
            cgColors.append(color.cgColor)
        }
        gradientLayer.frame = self.bounds
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .leftTopToRightBottom:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .rightTopToLeftBottom:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        
        for layer in layer.sublayers ?? [] {
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func getSubviews() -> [UIView] {
        var allViews: [UIView] = []

        for subview in self.subviews {
            allViews.append(subview)
            allViews.append(contentsOf: subview.getSubviews())
        }
        
        return allViews
    }
    
    func showTap(subview: UIView? = nil) {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = (subview != nil ? subview! : self).layer.cornerRadius
        view.frame = (subview != nil ? subview! : self).frame
        self.addSubview(view)
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false, block: {_ in
            view.removeFromSuperview()
        })
    }
    
    func disable(color: UIColor = .white) {
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = color.withAlphaComponent(0.5)
            view.tag = 987
            return view
        }()
        addSubview(view)
        view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        isUserInteractionEnabled = false
    }
    
    func enable() {
        subviews.first(where: { $0.tag == 987 })?.removeFromSuperview()
        isUserInteractionEnabled = true
    }
}
