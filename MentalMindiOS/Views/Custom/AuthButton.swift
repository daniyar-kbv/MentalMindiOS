//
//  AuthButton.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import SnapKit

class AuthButton: CustomButton {
    var type: AuthType? = .email {
        didSet {
            leftImage.image = type?.image
            setTitle(type?.buttonTitle, for: .normal)
        }
    }
    
    lazy var leftImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = StaticSize.size(5)
        layer.borderWidth = StaticSize.size(1)
        layer.borderColor = UIColor.customTextGray.cgColor
        setTitleColor(.customTextGray, for: .normal)
        titleLabel?.font = .montserrat(ofSize: StaticSize.size(16), weight: .regular)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([leftImage])
        
        leftImage.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(20))
            $0.centerY.equalToSuperview()
        })
    }
}
