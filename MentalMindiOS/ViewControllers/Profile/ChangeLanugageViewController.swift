//
//  ChangeLanugageViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import RxSwift

class ChangeLanugageViewController: BaseViewController {
    lazy var mainView = ChangeLanugageView()
    lazy var viewModel = UpdateProfileViewModel()
    lazy var disposeBag = DisposeBag()
    lazy var selectedLanguage = ModuleUserDefaults.getLanguage() {
        didSet {
            mainView.bottomButton.isActive = selectedLanguage != ModuleUserDefaults.getLanguage()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .darkContent
        mainView.setTitle("Сменить язык".localized)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.bottomButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        
        bind()
    }
    
    @objc func changeLanguage() {
        viewModel.updateProfile(language: selectedLanguage)
    }
    
    func bind() {
        viewModel.user.subscribe(onNext: { object in
            DispatchQueue.main.async {
                AppShared.sharedInstance.selectedLanguage = self.selectedLanguage
                self.navigationController?.popViewController(animated: true)
                AppShared.sharedInstance.tabBarController.reloadOnLanguageChange()
                AppShared.sharedInstance.setNotifications()
            }
        }).disposed(by: disposeBag)
    }
}

extension ChangeLanugageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseidentifier, for: indexPath) as! LanguageCell
        cell.language = Language.allCases[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! LanguageCell
            cell.isActive = indexPath.row == i
            if indexPath.row == i {
                selectedLanguage = cell.language ?? .ru
            }
        }
    }
}
