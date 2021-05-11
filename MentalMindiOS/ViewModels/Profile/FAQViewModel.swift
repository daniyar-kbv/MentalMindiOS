//
//  FAQViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 15.12.2020.
//

import Foundation
import RxSwift

class FAQViewModel: BaseViewModelDelegate {
    lazy var faqs = PublishSubject<[FAQ]>()
    
    var response: FAQResponse? {
        didSet {
            guard let faqs = response?.data?.results else { return }
            self.faqs.onNext(faqs)
        }
    }
    
    func getData() {
        APIManager.shared.faq() { error, response in
            self.response = response
        }
    }
}
