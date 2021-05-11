//
//  CalendarCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import SnapKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {
    static let reuseIdentifier = "CalendarCell"
    
    var date: Date? {
        didSet {
            dateLabel.text = date?.format(format: "d")
            isActive = date?.format() == Date().format()
        }
    }
    
    var isActive = false {
        didSet {
            container.backgroundColor = isActive ? .customBlue : .clear
            dateLabel.textColor = isActive ? .white : .customTextBlack
        }
    }
    
    lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.calendarCellSize / 2
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(13), weight: .medium)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([container, dateLabel])
        
        container.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        dateLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
}
