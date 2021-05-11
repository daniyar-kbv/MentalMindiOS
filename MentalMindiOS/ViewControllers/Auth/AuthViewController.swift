//
//  AuthViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation
import UIKit
import RxSwift

class AuthViewController: BaseViewController {
    lazy var authView = AuthView(type: type)
    lazy var viewModel: AuthViewModel = {
        let viewModel = AuthViewModel()
        viewModel.vc = self
        return viewModel
    }()
    lazy var disposeBag = DisposeBag()
    var type: AuthViewType
    
    required init(type: AuthViewType) {
        self.type = type
        
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        hideKeyboardWhenTappedAround(exculdeViews: authView.getSubviews().filter({
            if let btn = $0 as? UIButton {
                return btn.tag == 101
            }
            return false
        }))
        
        for view in authView.mainStack.arrangedSubviews as! [AuthField] {
            view.field.addTarget(self, action: #selector(onFieldChange(_:)), for: .editingChanged)
        }
        
        if type == .login {
            authView.bottomButton.isHidden = false
            authView.bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        }
        
        authView.forgotPasswordButton.addTarget(self, action: #selector(openForgotPassword), for: .touchUpInside)
        authView.button.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        
        bind()
    }
    
    func bind() {
        viewModel.userSubject.subscribe(onNext: { user in
            DispatchQueue.main.async {
                AppShared.sharedInstance.user = user
                let vc = NavigationMenuBaseController()
                AppShared.sharedInstance.tabBarController = vc as! NavigationMenuBaseController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)
        viewModel.registerUserSubject.subscribe(onNext: { user in
            DispatchQueue.main.async {
                self.showAlert(
                    title: "Добро пожаловать!".localized,
                    messsage: "Письмо с сылкой для подтверждения электронного адреса отправлено на Ваш почтовый ящик, необходимо подтвердить в течении 24 часов".localized,
                    actions: [
                        (
                            key: "Хорошо".localized,
                            value: { action in
                                self.navigationController?.popViewController(animated: true)
                            }
                        )
                    ]
                )
            }
        }).disposed(by: disposeBag)
        viewModel.restoreSuccess.subscribe(onNext: { success in
            DispatchQueue.main.async {
                self.showAlert(
                    title: "Отлично".localized,
                    messsage: "Письмо успешно отправлено, проверьте Ваш почтовый ящик".localized,
                    actions: [
                        (
                            key: "Хорошо".localized,
                            value: { action in
                                self.navigationController?.popViewController(animated: true)
                            }
                        )
                    ]
                )
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func mainButtonTapped() {
        switch type {
        case .login:
            if let email = (authView.mainStack.arrangedSubviews[0] as? AuthField)?.field.text, let password = (authView.mainStack.arrangedSubviews[1] as? AuthField)?.field.text {
                viewModel.login(email: email, password: password)
            }
        case .register:
            if let email = (authView.mainStack.arrangedSubviews[0] as? AuthField)?.field.text, let password = (authView.mainStack.arrangedSubviews[1] as? AuthField)?.field.text, let passwordRepeat = (authView.mainStack.arrangedSubviews[2] as? AuthField)?.field.text {
                viewModel.register(email: email, password: password, repeatPassword: passwordRepeat)
            }
        case .restoreEmail:
            if let email = (authView.mainStack.arrangedSubviews[0] as? AuthField)?.field.text {
                viewModel.restorePassword(email: email)
            }
        default:
            break
        }
    }
    
    @objc func onFieldChange(_ textField: UITextField) {
        var cnt = 0
        for view in authView.mainStack.arrangedSubviews as! [AuthField] {
            if view.isValid {
                cnt += 1
            }
        }
        authView.button.isActive = cnt == authView.mainStack.arrangedSubviews.count
    }
    
    @objc func openForgotPassword() {
        let vc = AuthViewController(type: .restoreEmail)
        navigationController?.pushViewController(AuthViewController(type: .restoreEmail), animated: true)
    }
    
    @objc func bottomButtonTapped() {
        let vc = AuthViewController(type: .register)
        navigationController?.pushViewController(vc, animated: true)
    }
}
