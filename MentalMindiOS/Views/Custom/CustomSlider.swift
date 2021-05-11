//
//  CustomSlider.swift
//  MentalMindiOS
//
//  Created by Daniyar on 08.12.2020.
//

import Foundation
import UIKit
import SnapKit

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
         let point = CGPoint(x: bounds.minX, y: bounds.midY)
         return CGRect(origin: point, size: CGSize(width: bounds.width, height: StaticSize.size(2)))
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds: CGRect = self.bounds
        bounds = bounds.insetBy(dx: -15, dy: -15)
        return bounds.contains(point)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        minimumTrackTintColor = .customBlue
        maximumTrackTintColor = UIColor.customBlue.withAlphaComponent(0.25)
        setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BackgroundVolumeSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
         let point = CGPoint(x: bounds.minX, y: bounds.midY)
         return CGRect(origin: point, size: CGSize(width: bounds.width, height: StaticSize.size(2)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        minimumValue = 0
        maximumValue = 1
        
        minimumTrackTintColor = .white
        maximumTrackTintColor = UIColor.customGray.withAlphaComponent(0.25)
        setThumbImage(UIImage(named: "knob"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
