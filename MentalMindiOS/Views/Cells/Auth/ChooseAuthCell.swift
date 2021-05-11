//
//  ChooseAuthCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import SnapKit

class ChooseAuthCell: UITableViewCell {
    static let reuseIdentifier = "ChooseAuthCell"
    
    var type: AuthType? {
        didSet {
            button.type = type
        }
    }
    
    lazy var button: AuthButton = {
        let view = AuthButton()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([button])
        
        button.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
