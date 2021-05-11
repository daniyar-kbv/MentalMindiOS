//
//  TabBartItemView.swift
//  GOALSTER
//
//  Created by Daniyar on 8/11/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class TabBarItemView: UIView {
    var item: TabItem
    var isActive: Bool? {
        didSet {
            guard let isActive = isActive else { return }
            itemIconView.image = isActive ? item.icon_active : item.icon_inactive
            titleLabel.textColor = isActive ? .customTextBlue : .customTextLightBlue
        }
    }
    
    lazy var itemIconView: UIImageView = {
        let view = UIImageView()
        view.image = item.icon_inactive
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(10), weight: .regular)
        label.textColor = .customTextLightBlue
        label.text = item.name
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    required init(item: TabItem) {
        self.item = item
        
        super.init(frame: .zero)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([itemIconView, titleLabel])
        
        itemIconView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(StaticSize.size(9))
            $0.size.equalTo(StaticSize.size(30))
        })
        
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(itemIconView.snp.bottom).offset(StaticSize.size(2))
            $0.centerX.equalToSuperview()
        })
    }
}
