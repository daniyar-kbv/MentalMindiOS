//
//  MeditaionDetailViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import RxSwift

class MeditaionDetailViewModel {
    lazy var action = PublishSubject<FavoriteMeditationAction>()
    var vc: MeditationDetailViewController?
    
    var addResponse: FavoriteAddResponse? {
        didSet {
            guard (addResponse?.data) != nil else { return }
            action.onNext(.add)
        }
    }
    
    var deleteResponse: FavoriteDeleteResponse? {
        didSet {
            guard (deleteResponse?.data) != nil else { return }
            action.onNext(.delete)
        }
    }
    
    func favorite(action: FavoriteMeditationAction) {
        if let meditationId = vc?.collection?.meditations?[vc?.currentMeditaion ?? 0].id, let collectionId = vc?.collection?.id{
            switch action{
            case .add:
                APIManager.shared.favoriteMeditationsAdd(meditationId: meditationId, collectionId: collectionId) { error, response in
                    self.addResponse = response
                }
            case .delete:
                APIManager.shared.favoriteMeditationsDelete(meditationId: meditationId, collectionId: collectionId) { error, response in
                    self.deleteResponse = response
                }
            }
        }
    }
    
    func sendHistory(meditation: Int, seconds: Int) {
        APIManager.shared.sendHistory(meditation: meditation, listenedSeconds: seconds) { error, response in
            
        }
    }
}
