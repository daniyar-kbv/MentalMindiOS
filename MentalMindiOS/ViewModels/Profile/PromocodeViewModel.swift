//
//  PromocodeViewModel.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import RxSwift

class PromocodeViewModel {
    lazy var data = PublishSubject<String>()
    
    var response: PromocodeResponse? {
        didSet {
            guard let data = response?.data else { return }
            self.data.onNext(data)
        }
    }
    
    func promocode(promocode: String) {
        APIManager.shared.promocode(promocode: promocode) { error, response in
            self.response = response
        }
    }
}
