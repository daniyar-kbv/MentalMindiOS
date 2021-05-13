//
//  File.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import SnapKit
import UIKit

class MainView: BaseView {
    lazy var topButton: GradientButton = {
        let view = GradientButton()
        view.layer.cornerRadius = StaticSize.size(15)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var topButtonTitle: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(17), weight: .bold)
        label.textColor = .white
        label.text = "Что беспокоит?".localized
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var plusImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "plus")
        return view
    }()
    
    lazy var tableView: TableView = {
        let view = TableView()
        return view
    }()
    
    required init() {
        super.init(titleOnTop: false)
        
        titleLabel.textColor = .customTextBlack
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([topButton, tableView])
        
        topButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(8))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(60))
        })
        
        topButton.addSubViews([plusImage, topButtonTitle])
        
        plusImage.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(18))
            $0.size.equalTo(StaticSize.size(24))
            $0.centerY.equalToSuperview()
        })
        
        topButtonTitle.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.size(12))
            $0.right.equalTo(plusImage.snp.left).offset(-StaticSize.size(12))
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(topButton.snp.bottom).offset(StaticSize.size(18))
            $0.left.right.bottom.equalToSuperview()
        })
    }
}
