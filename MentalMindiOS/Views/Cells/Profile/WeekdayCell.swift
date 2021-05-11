//
//  WeekdayCell.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import SnapKit

class WeekdayCell: UITableViewCell {
    static let reuseIdentifier = "WeekdayCell"
    
    var weekday: Weekday? {
        didSet {
            titleLabel.text = weekday?.name
        }
    }
    var isActive = false {
        didSet {
            radioImage.image = UIImage(named: isActive ? "radioOnWhite" : "radioOffWhite")
        }
    }
    
    lazy var radioImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "radioOffWhite")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(20), weight: .regular)
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        setUp()
    }
    
    func setUp() {
        contentView.addSubViews([radioImage, titleLabel])
        
        radioImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.size(24))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
        })
        
        titleLabel.snp.makeConstraints({
            $0.left.equalTo(radioImage.snp.right).offset(StaticSize.size(12))
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.centerY.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
