//
//  InputView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ProfileInputCell: UITableViewCell {
    static let reuseIdentifier = "ProfileInputView"
    var type: ProfileInputField<Any>.InputType
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(14), weight: .regular)
        view.textColor = .customTextGray
        view.text = type.title
        return view
    }()
    
    lazy var inputField: ProfileInputField<Any> = {
        let view = ProfileInputField<Any>(type: type)
        return view
    }()
    
    required init(type: ProfileInputField<Any>.InputType) {
        self.type = type
        
        super.init(style: .default, reuseIdentifier: ProfileInputCell.reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([title, inputField])
        
        title.snp.makeConstraints({
            $0.top.equalTo(StaticSize.size(10))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
        })
        
        inputField.snp.makeConstraints({
            $0.top.equalTo(title.snp.bottom).offset(StaticSize.size(6))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(45))
        })
    }
}

class ProfileInputField<T>: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    lazy var disposeBag = DisposeBag()
    var type: InputType
    var selectedItem: T?
    var items: [T] = [] {
        didSet {
            picker.reloadAllComponents()
            isUserInteractionEnabled = true
        }
    }
    
    lazy var arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowDownBlack")
        return view
    }()
    
    lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: StaticSize.size(200)))
        view.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        view.addTarget(self, action: #selector(onDateBegin), for: .editingDidBegin)
        view.datePickerMode = .date
        view.contentHorizontalAlignment = .center
        view.date = text?.toDate(format: "dd.MM.yyyy") ?? (AppShared.sharedInstance.user?.birthday?.toDate(format: "yyyy-MM-dd") ?? Date())
        view.setValue(UIColor.white, forKeyPath: "textColor")
        if #available(iOS 13.4, *) {
            view.preferredDatePickerStyle = .wheels
        }
        return view
    }()
    
    lazy var picker: UIPickerView = {
        let view = UIPickerView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: StaticSize.size(200)))
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    required init(type: InputType) {
        self.type = type
        
        super.init(frame: .zero)
        
        addTarget(self, action: #selector(editingBegin), for: .editingDidBegin)
        layer.cornerRadius = StaticSize.size(10)
        layer.borderWidth = StaticSize.size(1)
        layer.borderColor = UIColor.customTextBlack.cgColor
        font = .montserrat(ofSize: StaticSize.size(18), weight: .regular)
        textColor = .customTextBlue
        attributedPlaceholder = NSAttributedString(
            string: type.placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.customTextGray
            ]
        )
        
        switch type {
        case .name:
            text = AppShared.sharedInstance.user?.fullName
        case .DOB:
            inputView = datePicker
            let doneButton = UIBarButtonItem.init(title: "Готово".localized, style: .done, target: self, action: #selector(self.datePickerDone))
            let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 44))
            toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
            inputAccessoryView = toolBar
        case .country, .city:
            isUserInteractionEnabled = false
            inputView = picker
            let doneButton = UIBarButtonItem.init(title: "Готово".localized, style: .done, target: self, action: #selector(self.pickerDone))
            let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 44))
            toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
            inputAccessoryView = toolBar
            switch type {
            case .country:
                text = AppShared.sharedInstance.user?.country
            case .city:
                text = AppShared.sharedInstance.user?.city
            default:
                break
            }
        default:
            break
        }
        
        setUp()
        setText()
        bind()
    }
    
    func bind() {
        AppShared.sharedInstance.selectedCountrySubject.subscribe(onNext: { object in
            DispatchQueue.main.async {
                if self.type == .city {
                    self.items = (object.cities as? [T]) ?? []
                    if let city = self.selectedItem as? City, !(object.cities?.contains(where: { $0.id == city.id }) ?? false) {
                        self.text = ""
                        self.selectedItem = nil
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func editingBegin() {
        guard let index = items.firstIndex(where: {
            switch self.type {
            case .country:
                return ($0 as? Country)?.id == (self.selectedItem as? Country)?.id
            case .city:
                return ($0 as? City)?.id == (self.selectedItem as? City)?.id
            default:
                return false
            }
        }) else { return }
        picker.selectRow(index, inComponent: 0, animated: false)
    }
    
    @objc func onDateBegin() {
    }
    
    @objc func datePickerDone() {
        resignFirstResponder()
    }

    @objc func dateChanged() {
        text = datePicker.date.format(format: "dd.MM.yyyy")
    }
    
    @objc func pickerDone() {
        switch type {
        case .country:
            text = (selectedItem as? Country)?.name
            AppShared.sharedInstance.selectedCountry = selectedItem as? Country
        case .city:
            text = (selectedItem as? City)?.name
        default:
            break
        }
        resignFirstResponder()
    }
    
    func setText() {
        switch type {
        case .name:
            text = AppShared.sharedInstance.user?.fullName
        case .DOB:
            text = AppShared.sharedInstance.user?.birthday?.toDate(format: "yyyy-MM-dd")?.format(format: "dd.MM.yyyy")
        default:
            break
        }
    }
    
    func setUp() {
        if [InputType.city, InputType.country].contains(type) {
            addSubViews([arrowImage])
            
            arrowImage.snp.makeConstraints({
                $0.width.equalTo(StaticSize.size(15))
                $0.height.equalTo(StaticSize.size(9))
                $0.centerY.equalToSuperview()
                $0.right.equalToSuperview().offset(-StaticSize.size(17))
            })
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch type {
        case .country:
            return (items as? [Country])?[row].name
        case .city:
            return (items as? [City])?[row].name
        default:
            return nil
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: type.padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: type.padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: type.padding)
    }
    
    enum InputType {
        case name
        case DOB
        case country
        case city
        
        var title: String {
            switch self {
            case .name:
                return "Имя".localized
            case .DOB:
                return "Дата рождения".localized
            case .country:
                return "Страна".localized
            case .city:
                return "Город".localized
            }
        }
        
        var padding: UIEdgeInsets {
            switch self {
            case .name, .DOB:
                return UIEdgeInsets(top: 0, left: StaticSize.size(12), bottom: 0, right: StaticSize.size(12))
            case .city, .country:
                return UIEdgeInsets(top: 0, left: StaticSize.size(12), bottom: 0, right: StaticSize.size(49))
            }
        }
        
        var placeholder: String {
            switch self {
            case .name:
                return "Введите имя".localized
            case .DOB:
                return "ДД.ММ.ГГГГ".localized
            case .country, .city:
                return "Выберите из списка".localized
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
