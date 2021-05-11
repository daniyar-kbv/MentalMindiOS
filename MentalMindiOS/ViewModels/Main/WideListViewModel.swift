//
//  WideListViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import RxSwift

class WideListViewModel: BaseViewModelDelegate {
    lazy var collections = PublishSubject<[Collection]>()
    var superVc: WideListViewController<Any>?
    
    var response: ChallengeDetailResponse? {
        didSet {
            guard let collections = response?.data?.collections else { return }
            self.collections.onNext(collections)
        }
    }
    
    func getData() {
        guard let id = superVc?.challengeId else { return }
        APIManager.shared.challengeDetail(id: id) { error, response in
            self.response = response
        }
    }
}

