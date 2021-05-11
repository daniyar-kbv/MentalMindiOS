//
//  OnBoardingCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit

class OnBoardingCell: UICollectionViewCell {
    static let reuseIdentifier = "OnBoardingCell"
    
    lazy var title: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .montserrat(ofSize: StaticSize.size(26), weight: .bold)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var subtitle: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .montserrat(ofSize: StaticSize.size(16), weight: .regular)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, subtitle])
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = StaticSize.size(10)
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
