//
//  MeditationRateViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import RxSwift

class MeditationRateViewModel {
    var vc: MeditationRateViewController?
    
    lazy var response = PublishSubject<RateMeditationResponse>()
    
    func rateMeditation(star: Int) {
        if let currentMeditaion = vc?.superVc?.currentMeditaion, let meditation = vc?.superVc?.collection?.meditations?[currentMeditaion].id {
            vc?.mainView.isUserInteractionEnabled = false
            APIManager.shared.rateMeditation(star: star, meditation: meditation) { error, response in
                self.vc?.mainView.isUserInteractionEnabled = true
                guard let response = response else { return }
                self.response.onNext(response)
            }
        }
    }
}
