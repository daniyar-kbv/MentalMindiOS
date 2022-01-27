//
//  LevelsViewModel.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import RxSwift

class LevelsViewModel: BaseViewModelDelegate {
    lazy var levels = PublishSubject<[Level]>()
    
    var response: LevelsResponse? {
        didSet {
            guard let levels = response?.data?.results else { return }
            self.levels.onNext(levels)
        }
    }
    
    func getData() {
        APIManager.shared.levels() { error, response in
            self.response = response
        }
    }
}
