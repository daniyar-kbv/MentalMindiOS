//
//  CustomButton.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import StoreKit

class TappableButton: UIButton {
    var initialColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(holdDown), for: .touchUpInside)
        addTarget(self, action: #selector(holdRelease), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func holdDown() {
        backgroundColor = initialColor
    }

    @objc private func holdRelease() {
        initialColor = backgroundColor
        backgroundColor = initialColor?.withAlphaComponent(0.5)
    }
}


class CustomButton: TappableButton {
    var isActive: Bool = true {
        didSet {
            backgroundColor = backgroundColor?.withAlphaComponent(isActive ? 1 : 0.5)
            isUserInteractionEnabled = isActive
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = StaticSize.size(10)
        titleLabel?.font = .montserrat(ofSize: StaticSize.size(20), weight: .regular)
        setTitleColor(.customTextBlack, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GradientButton: UIButton {
    var colors: [UIColor]
    var locations: [NSNumber]
    var direction: Direction
    var initial = true
    
    required init(colors: [UIColor] = [.customBlue, .customGreen], locations: [NSNumber] = [0, 1], direction: Direction = .leftToRight) {
        self.colors = colors
        self.locations = locations
        self.direction = direction
        
        super.init(frame: .null)
        
        addTarget(self, action: #selector(holdDown), for: .touchUpInside)
        addTarget(self, action: #selector(holdRelease), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if initial {
            addGradientBackground(colors: colors, locations: locations, direction: direction)
        }
        
        initial = false
    }
    
    @objc private func holdDown() {
        addGradientBackground(
            colors: colors,
            locations: locations,
            direction: direction
        )
    }

    @objc private func holdRelease() {
        addGradientBackground(
            colors: colors.map({
                $0.withAlphaComponent(0.5)
            }),
            locations: locations,
            direction: direction
        )
    }
}
