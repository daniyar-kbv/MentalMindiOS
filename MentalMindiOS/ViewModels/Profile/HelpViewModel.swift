//
//  HelpViewModel.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import RxSwift

class HelpViewModel {
    lazy var success = PublishSubject<Bool>()
    
    var response: SuccessResponse? {
        didSet {
            guard let success = response?.data?.success else { return }
            self.success.onNext(success)
        }
    }
    
    func chelp(text: String) {
        APIManager.shared.help(text: text) { error, response in
            self.response = response
        }
    }
}

