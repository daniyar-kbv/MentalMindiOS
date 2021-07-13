//
//  PremiumPurchaseViewModel.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import RxSwift
import StoreKit

class PremiumPurchaseViewModel {
    lazy var tariffsResponse = PublishSubject<TariffsResponse?>()
    lazy var paymentResponse = PublishSubject<PaymentResponse?>()
    
    func getTariffs() {
        APIManager.shared.tariffs() { error, response in
            self.tariffsResponse.onNext(response)
        }
    }
    
    func payment(receipt: String, tariffId: Int) {
        APIManager.shared.payment(receipt: receipt, tariffId: tariffId) { error, response in
            ModuleUserDefaults.setIsPurchaseProcessed(true)
            self.paymentResponse.onNext(response)
        }
    }
}
