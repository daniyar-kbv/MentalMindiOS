//
//  PremiumPurchaseView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import UIKit
import SnapKit

class PremiumPurchaseView: PremiumBaseView {
    lazy var titleLabel: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .montserrat(ofSize: StaticSize.size(22), weight: .semiBold)
        view.textColor = .white
        view.text = "Разблокируй безграничные возможности себя и приложения Mentalmind".localized
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.delaysContentTouches = false
        view.contentInset = UIEdgeInsets(top: 0, left: StaticSize.size(16), bottom: 0, right: StaticSize.size(8))
        view.register(TariffCell.self, forCellWithReuseIdentifier: TariffCell.reuseIdentifier)
        return view
    }()
    
    lazy var descriptionView: PremiumDescriptionView = {
        let view = PremiumDescriptionView()
        return view
    }()
    
    required init() {
        super.init(type: .purchase)
    }
    
    func setUp() {
        contentView.addSubViews([titleLabel, collectionView, descriptionView])
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        collectionView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(25))
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(317.5))
        })
        
        descriptionView.snp.makeConstraints({
            $0.top.equalTo(collectionView.snp.bottom).offset(StaticSize.size(30))
            $0.left.right.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: ViewType) {
        fatalError("init(type:) has not been implemented")
    }
}
