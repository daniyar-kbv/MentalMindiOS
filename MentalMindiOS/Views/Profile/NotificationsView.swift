//
//  NotificationsView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import SnapKit

class NotificationsView: AuthBaseView {
    lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.date = AppShared.sharedInstance.notificationsWeekdays.key ?? Date()
        view.datePickerMode = .time
        if #available(iOS 13.4, *) {
            view.preferredDatePickerStyle = .wheels
        }
        for subview in view.subviews {
            subview.setValue(UIColor.white, forKeyPath: "textColor")
        }
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(WeekdayCell.self, forCellReuseIdentifier: WeekdayCell.reuseIdentifier)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.rowHeight = StaticSize.size(36)
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: StaticSize.size(18), left: 0, bottom: 0, right: 0)
        return view
    }()
    
    lazy var saveButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Сохранить".localized, for: .normal)
        return view
    }()
    
    required init() {
        super.init(titleOnTop: false)
        
        setUp()
    }
    
    func setUp() {
        contentView.addSubViews([datePicker, saveButton, tableView])
        
        datePicker.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(16))
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(216))
        })
        
        saveButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(datePicker.snp.bottom)
            $0.bottom.equalTo(saveButton.snp.top).offset(-StaticSize.size(15))
            $0.left.right.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
}
