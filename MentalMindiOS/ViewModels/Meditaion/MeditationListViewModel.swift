//
//  MeditationListViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation
import RxSwift

class MeditationListViewModel: BaseViewModelDelegate {
    lazy var collection = PublishSubject<CollectionDetail>()
    var superVc: MeditationListViewController?
    
    var response: CollectionDetailResponse? {
        didSet {
            guard let collection = response?.data else { return }
            self.collection.onNext(collection)
        }
    }
    
    func getData() {
        guard let id = superVc?.collectionId else { return }
        APIManager.shared.collectionDetail(id: id) { error, response in
            self.response = response
        }
    }
}
