//
//  ProfileItemContainer.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import SnapKit

class ProfileItemContainer: UIView {
    lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(18), weight: .medium)
        label.textColor = .customTextBlack
        label.numberOfLines = 0
        return label
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topView, contentView])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.size(5)
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
            $0.edges.equalToSuperview()
        })
        
        topView.addSubViews([titleLabel])
        
        titleLabel.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
    
    func setView(_ view: UIView) {
        contentView.addSubview(view)
        
        view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
