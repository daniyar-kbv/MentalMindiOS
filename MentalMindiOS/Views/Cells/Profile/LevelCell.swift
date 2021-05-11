//
//  LevelCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import SnapKit

class LevelCell: UITableViewCell {
    static let reuseIdentifier = "LevelCell"
    
    var level: Level? {
        didSet {
            titleLabel.text = "\("Уровень".localized) “\(level?.label ?? "")”"
            levelView.level = level
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(18), weight: .medium)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var levelView: LevelView = {
        let view = LevelView()
        view.type = .profile
        view.level = level
        view.questionButton.isHidden = true
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
        contentView.addSubViews([titleLabel, levelView])
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        levelView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.levelViewHeight)
        })
    }
}
