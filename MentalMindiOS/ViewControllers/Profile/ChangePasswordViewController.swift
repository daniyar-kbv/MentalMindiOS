//
//  ChangePasswordViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import RxSwift

class ChangePasswordViewController: BaseViewController {
    lazy var mainView = ChangePasswordView()
    lazy var viewModel = ChangePasswordViewModel()
    lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .darkContent
        hideKeyboardWhenTappedAround()
        
        mainView.oldPawwordView.field.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        mainView.newPawwordView.field.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        mainView.repeatPawwordView.field.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        mainView.bottomButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        bind()
    }
    
    @objc func fieldChanged() {
        mainView.bottomButton.isActive = !mainView.oldPawwordView.field.isEmpty() && !mainView.newPawwordView.field.isEmpty() && !mainView.repeatPawwordView.field.isEmpty()
    }
    
    @objc func buttonTapped() {
        guard mainView.newPawwordView.field.text == mainView.repeatPawwordView.field.text else {
            showAlert(title: "Пароли не совпадают".localized)
            return
        }
        if let old = mainView.oldPawwordView.field.text, let new = mainView.newPawwordView.field.text {
            viewModel.changePassword(oldPassword: old, newPassword: new)
        }
    }
    
    func bind() {
        viewModel.success.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.showAlert(
                    title: "Пароль изменен успешно".localized,
                    actions: [(
                                key: "Ок",
                                value: { action in
                                    self.navigationController?.popViewController(animated: true)
                                }
                    )]
                )
            }
        }).disposed(by: disposeBag)
    }
}
