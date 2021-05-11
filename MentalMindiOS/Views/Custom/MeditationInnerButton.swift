//
//  MeditationInnerButtom.swift
//  MentalMindiOS
//
//  Created by Daniyar on 08.12.2020.
//

import Foundation
import UIKit
import SnapKit

class MeditationInnerButton: UIButton {
    var type: MeditationButtonType
    
    lazy var leftImage: UIImageView = {
        let view = UIImageView()
        view.image = type.image
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(10), weight: .regular)
        label.textColor = .customTextBlue
        label.text = type.title
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var value: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(12), weight: .bold)
        label.textColor = .customTextBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, value])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.isUserInteractionEnabled = false
        return view
    }()
    
    required init(type: MeditationButtonType){
        self.type = type
        
        super.init(frame: .zero)
        
        layer.cornerRadius = StaticSize.size(20.5)
        layer.borderWidth = StaticSize.size(1)
        layer.borderColor = UIColor.customTextBlue.cgColor
        layer.masksToBounds = true
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([leftImage, stack])
        
        leftImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.size(25))
            $0.left.equalToSuperview().offset(StaticSize.size(13))
        })
        
        stack.snp.makeConstraints({
            $0.left.equalTo(leftImage.snp.right).offset(StaticSize.size(6))
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-StaticSize.size(10))
        })
    }
}
