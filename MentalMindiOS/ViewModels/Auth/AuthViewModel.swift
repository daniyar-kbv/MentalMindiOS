//
//  AuthViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation
import RxSwift

class AuthViewModel {
    lazy var userSubject = PublishSubject<User>()
    lazy var registerUserSubject = PublishSubject<User>()
    lazy var restoreSuccess = PublishSubject<Bool>()
    var vc: AuthViewController?
    
    var loginResponse: LoginResponse? {
        didSet {
            guard let user = loginResponse?.data?.user, let token = loginResponse?.data?.accessToken else {
                return
            }
            
            userSubject.onNext(user)
            ModuleUserDefaults.setToken(token)
            ModuleUserDefaults.setIsLoggedIn(true)
        }
    }
    
    var registerResponse: RegisterResponse? {
        didSet {
            guard let user = registerResponse?.data else {
                return
            }
            
            registerUserSubject.onNext(user)
        }
    }
    
    var passwordRestoreResponse: PasswordRestoreResponse? {
        didSet {
            guard let success = passwordRestoreResponse?.success else {
                return
            }
            
            restoreSuccess.onNext(success)
        }
    }
    
    func login(email: String, password: String) {
        APIManager.shared.login(email: email, password: password) { error, response in
            if let error = error {
                return
            }
            self.loginResponse = response
        }
    }
    
    func register(email: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            vc?.showAlert(title: "Пароли не совпадают".localized)
            return
        }
        APIManager.shared.register(email: email, password: password) { error, response in
            if let error = error {
                return
            }
            self.registerResponse = response
        }
    }
    
    func restorePassword(email: String) {
        APIManager.shared.restorePassword(email: email) { error, response in
            if let error = error {
                return
            }
            
            self.passwordRestoreResponse = response
        }
    }
}
