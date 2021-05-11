//
//  MeditationRateView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import UIKit
import SnapKit
import Cosmos

class MeditationRateView: MeditationInnerBaseView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(24), weight: .medium)
        label.textColor = .white
        label.text = "Оцените медитацию".localized
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var ratingView: CosmosView = {
        let view = CosmosView()
        view.rating = 4
        view.rating = 0
        view.settings.fillMode = .full
        view.settings.starSize = Double(StaticSize.size(24))
        view.settings.starMargin = Double(StaticSize.size(15))
        view.settings.filledImage = UIImage(named: "starOn")
        view.settings.emptyImage = UIImage(named: "starOff")
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, ratingView])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .center
        view.spacing = StaticSize.size(40)
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
        addSubViews([stack])
        
        stack.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
}
