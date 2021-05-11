//
//  SubscriptionView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 15.12.2020.
//

import Foundation
import UIKit
import SnapKit

class SubscriptionView: UIView {
    lazy var button: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customLightGreen
        view.setTitle("Купить подписку".localized, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(openPurchases), for: .touchUpInside)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [button])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([stackView])
        
        stackView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(14))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview().offset(-StaticSize.size(15))
        })
        
        button.snp.makeConstraints({
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
    
    @objc func openPurchases() {
        AppShared.sharedInstance.navigationController.pushViewController(PremiumPreviewViewController(), animated: true)
    }
}
