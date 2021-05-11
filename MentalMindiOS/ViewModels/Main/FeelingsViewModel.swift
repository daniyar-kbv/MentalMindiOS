//
//  FeelingsViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import RxSwift

class FeelingsViewModel: BaseViewModelDelegate {
    lazy var feelings = PublishSubject<[Feeling]>()
    
    var response: FeelingsResponse? {
        didSet {
            guard let feelings = response?.data?.results else { return }
            self.feelings.onNext(feelings)
        }
    }
    
    func getData() {
        APIManager.shared.feelings() { error, response in
            self.response = response
        }
    }
}
