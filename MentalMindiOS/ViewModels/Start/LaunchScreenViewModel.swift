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
    lazy var paymentResponse = PublishSubject<PaymentResponse?>()
    
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
    
    func payment(receipt: String, tariffId: Int) {
        APIManager.shared.payment(receipt: receipt, tariffId: tariffId) { error, response in
            ModuleUserDefaults.setIsPurchaseProcessed(true)
            self.paymentResponse.onNext(response)
        }
    }
}

protocol BaseViewModelDelegate {
    func getData()
}
