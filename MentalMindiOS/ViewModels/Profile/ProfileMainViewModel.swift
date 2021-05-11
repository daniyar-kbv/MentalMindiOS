//
//  ProfileMainViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import RxSwift

class ProfileMainViewModel {
    lazy var user = PublishSubject<User>()
    lazy var level = PublishSubject<Level>()
    lazy var gotData = PublishSubject<Bool>()
    var vc: ProfileMainViewController?
    
    var gotResponses = 0
    var requestsNumber = 2
    var loader: Loader?
    
    var userResponse: MeResponse? {
        didSet {
            guard let user = userResponse?.data else { return }
            self.user.onNext(user)
        }
    }
    
    var levelResponse: MyLevelResponse? {
        didSet {
            guard let level = levelResponse?.data else { return }
            self.level.onNext(level)
        }
    }
    
    func getUserData() {
        loader = Loader.show(vc?.mainView)
        APIManager.shared.me() { userError, userResponse in
            self.moveLoader()
            if let level = userResponse?.data?.level {
                APIManager.shared.myLevel(id: level) { levelError, levelResponse in
                    self.moveLoader()
                    self.userResponse = userResponse
                    self.levelResponse = levelResponse
                    self.gotData.onNext(true)
                }
            }
        }
    }
    
    func moveLoader() {
        gotResponses += 1
        loader?.setProgress(100 * Float(gotResponses / requestsNumber))
    }
}
