//
//  LanguageCell.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import SnapKit

class LanguageCell: UITableViewCell {
    static let reuseidentifier = "LanguageCell"

    var isActive = false {
        didSet {
            radioImage.image = UIImage(named: isActive ? "radioOn" : "radioOff")
        }
    }
    var language: Language? {
        didSet {
            titleLabel.text = language?.name
            isActive = language == AppShared.sharedInstance.selectedLanguage
        }
    }
    
    lazy var radioImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "radioOff")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(16), weight: .medium)
        view.textColor = .customTextBlack
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([radioImage, titleLabel])
        
        radioImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(24))
        })
        
        titleLabel.snp.makeConstraints({
            $0.left.equalTo(radioImage.snp.right).offset(StaticSize.size(12))
            $0.centerY.equalToSuperview()
        })
    }
}
