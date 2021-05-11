//
//  ProfileMainInfoCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import SnapKit

class ProfileMainInfoCell: UITableViewCell {
    static let reuseIdentifier = "ProfileMainInfoCell"
    
    var type: ProfileInfoCellType? {
        didSet {
            titleLabel.text = type?.title
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(20), weight: .regular)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var arrow: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowRight")
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
        contentView.addSubViews([arrow, titleLabel])
        
        arrow.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(16))
            $0.centerY.equalToSuperview()
            $0.width.equalTo(StaticSize.size(9))
            $0.height.equalTo(StaticSize.size(15))
        })
        
        titleLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.right.equalTo(arrow.snp.left).offset(-StaticSize.size(15))
            $0.centerY.equalToSuperview()
        })
    }
}
