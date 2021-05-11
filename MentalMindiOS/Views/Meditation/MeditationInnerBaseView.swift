//
//  MeditationInnerBaseView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import UIKit
import SnapKit

class MeditationInnerBaseView: UIView {
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "closeSquare"), for: .normal)
        view.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGradientBackground()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews([backButton])
        
        backButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop() + StaticSize.size(6))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(40))
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backTapped() {
        AppShared.sharedInstance.navigationController.popViewController(animated: true)
    }
}
