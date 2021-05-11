//
//  TwoStatesButton.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation
import UIKit

class TwoStatesButton: UIButton {
    var activeImage: UIImage?
    var inactiveImage: UIImage?
    var isActive: Bool {
        didSet {
            setBackgroundImage(isActive ? activeImage : inactiveImage, for: .normal)
        }
    }
    
    required init(activeImage: UIImage?, inactiveImage: UIImage?, isActive: Bool = false) {
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        self.isActive = isActive
        
        super.init(frame: .zero)
        
        setBackgroundImage(isActive ? activeImage : inactiveImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
