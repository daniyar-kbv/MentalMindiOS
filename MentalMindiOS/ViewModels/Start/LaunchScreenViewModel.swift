//
//  LaunchScreenVuewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import RxSwift

class LaunchScreenViewModel {
    lazy var data = PublishSubject<SubscriptionStatusData>()
    
    var response: SubscriptionStatusResponse? {
        didSet {
            guard let data = response?.data else {
                return
            }
            
            self.data.onNext(data)
        }
    }
    
    func subscriptionStatus() {
        APIManager.shared.subscriptionStatus() { error, response in
            self.response = response
        }
    }
}

protocol BaseViewModelDelegate {
    func getData()
}
