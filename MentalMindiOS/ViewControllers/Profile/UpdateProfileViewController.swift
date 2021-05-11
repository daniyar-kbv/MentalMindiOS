//
//  UpdateProfileViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import RxSwift

class UpdateProfileViewController: BaseViewController {
    lazy var mainView = UpdateProfileView()
    lazy var viewModel = UpdateProfileViewModel()
    lazy var disposeBag = DisposeBag()
    
    lazy var items: [ProfileInputField<Any>.InputType] = [.name, .DOB, .country, .city]
    var countries: [Country] = [] {
        didSet {
            for i in 0..<mainView.tableView.numberOfRows(inSection: 0) {
                let cell = mainView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! ProfileInputCell
                switch cell.type {
                case .country:
                    cell.inputField.items = countries
                    if let country = AppShared.sharedInstance.user?.country {
                        cell.inputField.selectedItem = countries.first(where: { $0.name == country })
                    } else if countries.count == 1 {
                        cell.inputField.selectedItem = countries.first
                        cell.inputField.text = countries.first?.name
                    }
                case .city:
                    if let country = AppShared.sharedInstance.user?.country, let city = AppShared.sharedInstance.user?.city {
                        cell.inputField.selectedItem = countries.first(where: { $0.name == country })?.cities?.first(where: { $0.name == city })
                    } else if countries.count == 1 {
                        cell.inputField.items = countries.first?.cities ?? []
                    }
                default:
                    break
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.setTitle("Настройки".localized)
        mainView.barStyle = .darkContent
        statusBarStyle = .darkContent
        mainView.setTableHeight(count: items.count)
        hideKeyboardWhenTappedAround()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.passwordButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        mainView.bottomButton.addTarget(self, action: #selector(onSaveTapped), for: .touchUpInside)
        
        viewModel.getCountries()
        
        bind()
    }
    
    func bind() {
        viewModel.user.subscribe(onNext: { object in
            DispatchQueue.main.async {
                AppShared.sharedInstance.user = object
                self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
        viewModel.countries.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.countries = object
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func changePasswordTapped() {
        navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
    }
    
    @objc func onSaveTapped() {
        var name: String?
        var birthday: String?
        var country: String?
        var city: String?
        for i in 0..<mainView.tableView.numberOfRows(inSection: 0) {
            let cell = mainView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! ProfileInputCell
            switch cell.type {
            case .name:
                if cell.inputField.text != AppShared.sharedInstance.user?.fullName {
                    name = cell.inputField.text
                }
            case .DOB:
                if cell.inputField.text?.toDate(format: "dd.MM.yyyy") != AppShared.sharedInstance.user?.birthday?.toDate(format: "yyyy-MM-dd") {
                    birthday = cell.inputField.text?.toDate(format: "dd.MM.yyyy")?.format(format: "yyyy-MM-dd")
                }
            case .country:
                if cell.inputField.text != AppShared.sharedInstance.user?.country {
                    country = cell.inputField.text
                }
            case .city:
                if cell.inputField.text != AppShared.sharedInstance.user?.city {
                    city = cell.inputField.text
                }
            }
        }
        if name != nil || birthday != nil || country != nil || city != nil {
            viewModel.updateProfile(fullName: name, birthday: birthday, country: country, city: city)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension UpdateProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileInputCell(type: items[indexPath.row])
        return cell
    }
}
