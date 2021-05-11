//
//  HistoryCell.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import SnapKit

class HistoryCell: UITableViewCell {
    static let reuseIdentifier = "HistoryCell"
    
    var record: HistoryRecord? {
        didSet {
            titleLabel.text = record?.meditation
        }
    }
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(14), weight: .medium)
        view.textColor = .customTextBlack
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
        addSubViews([titleLabel])
        
        titleLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
