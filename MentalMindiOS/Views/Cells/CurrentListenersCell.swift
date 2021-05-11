//
//  CurrentListenersCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import SnapKit

class CurrentListenersCell: UITableViewCell {
    static let reuseIdentifier = "CurrentListenersCell"
    
    lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.size(15)
        view.layer.borderWidth = StaticSize.size(1)
        view.layer.borderColor = UIColor.customBlue.cgColor
        return view
    }()
    
    lazy var number: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(34), weight: .medium)
        label.textColor = .customBlue
        label.adjustsFontSizeToFitWidth = true
        label.text = "32 890"
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(16), weight: .medium)
        label.textColor = .customBlue
        label.adjustsFontSizeToFitWidth = true
        label.text = "Сейчас".localized
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(13), weight: .medium)
        label.textColor = .customBlue
        label.adjustsFontSizeToFitWidth = true
        label.text = "слушают медитации".localized
        return label
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, subtitle])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([container])
        
        container.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(StaticSize.size(1))
            $0.left.right.equalToSuperview().inset(StaticSize.size(32))
        })
        
        container.addSubViews([number, stack])
        
        number.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.size(19))
        })
        
        stack.snp.makeConstraints({
            $0.left.equalTo(number.snp.right).offset(StaticSize.size(14))
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-StaticSize.size(19))
        })
    }
}
