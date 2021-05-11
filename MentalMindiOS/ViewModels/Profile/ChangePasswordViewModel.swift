//
//  ChangePasswordViewModel.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import RxSwift

class ChangePasswordViewModel {
    lazy var success = PublishSubject<Bool>()
    
    var response: SuccessResponse? {
        didSet {
            guard let success = response?.data?.success else { return }
            self.success.onNext(success)
        }
    }
    
    func changePassword(oldPassword: String, newPassword: String) {
        APIManager.shared.changePassword(oldPassword: oldPassword, newPassword: newPassword) { error, response in
            self.response = response
        }
    }
}
