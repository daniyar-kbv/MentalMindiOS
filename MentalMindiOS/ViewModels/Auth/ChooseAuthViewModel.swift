//
//  ChooseAuthViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation
import RxSwift

class ChooseAuthViewModel {
    lazy var userSubject = PublishSubject<User>()
    
    var response: LoginResponse? {
        didSet {
            guard let user = response?.data?.user, let token = response?.data?.accessToken else {
                return
            }
            
            userSubject.onNext(user)
            ModuleUserDefaults.setToken(token)
            ModuleUserDefaults.setIsLoggedIn(true)
        }
    }
    
    func socialLogin(type: AuthType?, token: String, email: String?, fullName: String?) {
        APIManager.shared.socialLogin(type: type, token: token, email: email, fullName: fullName) { error, response in
            self.response = response
        }
    }
}
