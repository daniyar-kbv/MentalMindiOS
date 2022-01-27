//
//  PremiumPreviewView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import UIKit
import SnapKit

class PremiumPreviewView: PremiumBaseView {
    lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "launchLogo")
        return view
    }()
    
    lazy var appNameLabel: UILabel = {
        let view = UILabel()
        view.font = .jura(ofSize: StaticSize.size(24), weight: .light)
        view.textColor = .white
        view.text = "Mentalmind"
        return view
    }()
    
    lazy var descriptionView: PremiumDescriptionView = {
        let view = PremiumDescriptionView()
        return view
    }()
    
    lazy var privacyButton: PolicyButton = {
        let view = PolicyButton()
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customLightGreen
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Перейти к тарифам".localized, for: .normal)
        view.isActive = false
        return view
    }()
    
    required init() {
        super.init(type: .preview)
        
        policyButton.isHidden = true
        
        setUp()
    }
    
    func setUp() {
        contentView.addSubViews([logoImage, appNameLabel, descriptionView, privacyButton, bottomButton])
        
        logoImage.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(82))
            $0.centerX.equalToSuperview()
            $0.size.equalTo(StaticSize.size(92))
        })
        
        appNameLabel.snp.makeConstraints({
            $0.top.equalTo(logoImage.snp.bottom).offset(StaticSize.size(13))
            $0.centerX.equalToSuperview()
        })
        
        descriptionView.snp.makeConstraints({
            $0.top.equalTo(appNameLabel.snp.bottom).offset(StaticSize.size(95))
            $0.left.right.equalToSuperview()
        })
        
        privacyButton.snp.makeConstraints({
            $0.top.equalTo(descriptionView.snp.bottom).offset(StaticSize.size(96))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        bottomButton.snp.makeConstraints({
            $0.top.equalTo(privacyButton.snp.bottom).offset(StaticSize.size(16))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: ViewType) {
        fatalError("init(type:) has not been implemented")
    }
}
