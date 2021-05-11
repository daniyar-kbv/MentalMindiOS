//
//  MoreButton.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation
import UIKit
import SnapKit

class MoreButton: UIButton {
    var isActive: Bool = false {
        didSet {
            setTitle(isActive ? "Свернуть".localized : "Развернуть".localized, for: .normal)
            setImage(UIImage(named: isActive ? "arrowUp" : "arrowDown"), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("Развернуть".localized, for: .normal)
        setTitleColor(.customTextBlue, for: .normal)
        titleLabel?.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        setImage(UIImage(named: "arrowDown"), for: .normal)
        let width = "Развернуть".localized.width(withConstrainedHeight: StaticSize.size(15), font: .montserrat(ofSize: StaticSize.size(12), weight: .regular))
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: ((StaticSize.size(103) - width) / 2) - ((StaticSize.size(103) - (width + StaticSize.size(22))) / 2))
        imageEdgeInsets = UIEdgeInsets(top: StaticSize.size(2), left: StaticSize.size(103) - ((StaticSize.size(103) - (width + StaticSize.size(22))) / 2) - StaticSize.size(5), bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
