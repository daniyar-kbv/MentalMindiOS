//
//  HistoryCalendar.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import SnapKit
import JTAppleCalendar

class HistoryCalendar: UIView {
    lazy var currentCalendar = Calendar.current
    lazy var date = Date()
    lazy var year: Int = currentCalendar.component(.year, from: date)
    lazy var month: Int = currentCalendar.component(.month, from: date)
    lazy var startWeekDay: Int = date.startOfMonth.weekday
    lazy var numberOfDays: Int = currentCalendar.range(of: .day, in: .month, for: date)?.count ?? 0
    lazy var selectedDate: Date? = Date()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = StaticSize.size(3)
        view.layer.shadowOffset = CGSize(width: 0, height: StaticSize.size(1))
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    lazy var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = StaticSize.size(10)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(16), weight: .semiBold)
        label.textColor = .customTextBlack
        label.text = "\(Month(rawValue: currentCalendar.component(.month, from: date))?.name ?? "") \(year)"
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "calendarLeft"), for: .normal)
        view.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        return view
    }()
    
    lazy var rightButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "calendarRight"), for: .normal)
        view.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        return view
    }()
    
    lazy var weekdaysStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        for i in 0..<7 {
            let label: UILabel = {
                let label = UILabel()
                label.font = .montserrat(ofSize: StaticSize.size(12), weight: .medium)
                label.textColor = UIColor.customTextBlack.withAlphaComponent(0.5)
                label.textAlignment = .center
                switch i {
                case 0:
                    label.text = "Пн".localized
                case 1:
                    label.text = "Вт".localized
                case 2:
                    label.text = "Ср".localized
                case 3:
                    label.text = "Чт".localized
                case 4:
                    label.text = "Пт".localized
                case 5:
                    label.text = "Сб".localized
                case 6:
                    label.text = "Вс".localized
                default:
                    break
                }
                return label
            }()
            view.addArrangedSubview(label)
        }
        return view
    }()
    
    lazy var calendar: JTAppleCalendarView = {
        let view = JTAppleCalendarView()
        view.minimumLineSpacing = 0
        view.minimumInteritemSpacing = 0
        view.calendarDelegate = self
        view.calendarDataSource = self
        view.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.reuseIdentifier)
        view.cellSize = StaticSize.size(47)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customBlue
        view.setTitle("Посмотреть по дням".localized, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(17), weight: .medium)
        view.addTarget(self, action: #selector(openTapped), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func openTapped() {
        let vc = HistoryViewController()
        vc.date = selectedDate
        AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
    }
    
    func setUp() {
        addSubViews([shadowView])
        
        shadowView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(10))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview().offset(-StaticSize.size(25))
        })
        
        shadowView.addSubViews([mainContainer])
        
        mainContainer.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        mainContainer.addSubViews([titleLabel, leftButton, rightButton, weekdaysStack, calendar, bottomButton])
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(20))
            $0.centerX.equalToSuperview()
        })
        
        leftButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(15))
            $0.left.equalToSuperview().offset(StaticSize.size(25))
            $0.size.equalTo(StaticSize.size(24))
        })
        
        rightButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(15))
            $0.right.equalToSuperview().offset(-StaticSize.size(25))
            $0.size.equalTo(StaticSize.size(24))
        })
        
        weekdaysStack.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(23))
            $0.left.right.equalToSuperview().inset(StaticSize.size(7))
            $0.height.equalTo(StaticSize.size(25))
        })
        
        calendar.snp.makeConstraints({
            $0.top.equalTo(weekdaysStack.snp.bottom).offset(StaticSize.size(19))
            $0.left.right.equalToSuperview().inset(StaticSize.size(7))
            $0.height.equalTo(
                StaticSize.calendarCellSize * CGFloat(ceil((Double(numberOfDays) + Double(startWeekDay - 1)) / 7))
            )
        })
        
        bottomButton.snp.makeConstraints({
            $0.top.equalTo(calendar.snp.bottom).offset(StaticSize.size(17))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.bottom.equalToSuperview().offset(StaticSize.size(-17))
        })
    }
}

extension HistoryCalendar: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CalendarCell.reuseIdentifier, for: indexPath) as! CalendarCell
        cell.date = date
        cell.isHidden = !(cellState.dateBelongsTo == .thisMonth)
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = date
        let endDate = date
        return ConfigurationParameters(startDate: startDate, endDate: endDate, generateInDates: .forAllMonths, generateOutDates: .tillEndOfRow, firstDayOfWeek: .monday)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        for i in 0..<calendar.numberOfItems(inSection: 0) {
            let cell = calendar.cellForItem(at: IndexPath(item: i, section: 0)) as! CalendarCell
            cell.isActive = cell.date == date
            if cell.date == date {
                selectedDate = cell.date
            }
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    }
    
    @objc func nextMonth() {
        if month != 12 {
            month += 1
        } else {
            month = 1
            year += 1
        }
        updateCalendar()
    }
    
    @objc func previousMonth() {
        if month != 1 {
            month -= 1
        } else {
            month = 12
            year -= 1
        }
        updateCalendar()
    }
    
    func updateCalendar() {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = 1
        date = currentCalendar.date(from: dateComponents) ?? Date()
        startWeekDay = date.startOfMonth.weekday
        numberOfDays = currentCalendar.range(of: .day, in: .month, for: date)?.count ?? 0
        titleLabel.text = "\(Month(rawValue: currentCalendar.component(.month, from: date))?.name ?? "") \(year)"
        calendar.snp.updateConstraints({
            $0.height.equalTo(
                StaticSize.calendarCellSize * CGFloat(ceil((Double(numberOfDays) + Double(startWeekDay - 1)) / 7))
            )
        })
        calendar.reloadData()
    }
}
