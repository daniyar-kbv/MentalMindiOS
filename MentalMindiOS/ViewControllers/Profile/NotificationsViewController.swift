//
//  NotificationsViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit

class NotificationsViewController: BaseViewController {
    lazy var mainView = NotificationsView()
    var selectedWeekdays: (key: Date?, value: [Weekday]?) = AppShared.sharedInstance.notificationsWeekdays
    var superVc: ProfileMainViewController?
    var saved = false
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        superVc?.mainView.notificationsSwitch.setOn(!(AppShared.sharedInstance.notificationsWeekdays.value?.isEmpty ?? true), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mainView.tableView.isScrollEnabled = !(mainView.tableView.frame.height > mainView.tableView.rowHeight * CGFloat(mainView.tableView.numberOfRows(inSection: 0)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        mainView.setTitle("Напоминание о медитации".localized)
        
        mainView.saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    @objc func saveTapped() {
        selectedWeekdays.key = mainView.datePicker.date
        AppShared.sharedInstance.notificationsWeekdays = selectedWeekdays
        AppShared.sharedInstance.setNotifications()
        navigationController?.popViewController(animated: true)
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Weekday.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekdayCell.reuseIdentifier, for: indexPath) as! WeekdayCell
        cell.weekday = Weekday.allCases[indexPath.row]
        cell.isActive = selectedWeekdays.value?.contains(Weekday.allCases[indexPath.row]) ?? false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WeekdayCell
        cell.isActive.toggle()
        switch cell.weekday {
        case .everyDay:
            if cell.isActive {
                for i in 1..<tableView.numberOfRows(inSection: 0) {
                    let cell_ = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! WeekdayCell
                    cell_.isActive = false
                }
            }
        default:
            (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! WeekdayCell).isActive = false
        }
        selectedWeekdays.value = Array(0..<tableView.numberOfRows(inSection: 0)).map({
            tableView.cellForRow(at: IndexPath(row: $0, section: 0)) as! WeekdayCell
        }).filter({
            $0.isActive
        }).map({
            ($0.weekday ?? .everyDay)
        })
    }
}
