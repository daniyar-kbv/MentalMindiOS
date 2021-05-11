//
//  VoiceButton.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import UIKit
import SnapKit

class VoiceButton: UIButton {
    var onTap: ((_: VoiceTypes)->())?
    var type: VoiceTypes
    var isActive = false {
        didSet {
            backgroundColor = isActive ? .white : .clear
            setTitleColor(isActive ? .customTextBlue : .white, for: .normal)
        }
    }
    
    required init(type: VoiceTypes) {
        self.type = type
        
        super.init(frame: .zero)
        
        isActive = type == .female
        
        layer.cornerRadius = StaticSize.size(17)
        layer.borderWidth = StaticSize.size(1)
        layer.borderColor = UIColor.white.cgColor
        
        backgroundColor = isActive ? .white : .clear
        setTitleColor(isActive ? .customTextBlue : .white, for: .normal)
        setTitle(type.title, for: .normal)
        titleLabel?.font = .montserrat(ofSize: StaticSize.size(17), weight: .regular)
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: StaticSize.size(11), bottom: 0, right: StaticSize.size(11))
        
        addTarget(self, action: #selector(onSelfTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSelfTap() {
        if let superview = superview as? UIStackView {
            for view in superview.arrangedSubviews as? [VoiceButton] ?? [] {
                view.isActive = view == self
            }
        }
        onTap?(type)
    }
}
