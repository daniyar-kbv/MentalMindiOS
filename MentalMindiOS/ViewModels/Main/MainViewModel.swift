//
//  MainViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import RxSwift

class MainViewModel {
    lazy var recommendations = PublishSubject<[Collection]>()
    lazy var collections = PublishSubject<[Collection]>()
    lazy var meditaions = PublishSubject<[Meditation]>()
    lazy var challenges = PublishSubject<[Challenge]>()
    lazy var courses = PublishSubject<[Course]>()
    lazy var currentListenersAmount = PublishSubject<Int>()
    lazy var gotData = PublishSubject<Bool>()
    var dataMax = 0
    var dataCount = 0 {
        didSet {
            if dataMax == dataCount {
                gotData.onNext(true)
            }
        }
    }
    var loader: Loader?
    var vc: MainViewController?
    
    var recommendationsResponse: CollectionsResponse? {
        didSet {
            guard let collections = recommendationsResponse?.data?.results else {
                moveLoader()
                return
            }
            self.recommendations.onNext(collections)
            moveLoader()
        }
    }
    
    var collectionsResponse: CollectionsResponse? {
        didSet {
            guard let collections = collectionsResponse?.data?.results else {
                moveLoader()
                return
            }
            self.collections.onNext(collections)
            moveLoader()
        }
    }
    
    var meditaionsResponse: FavoriteMeditationsResponse? {
        didSet {
            guard let meditaions = meditaionsResponse?.data?.results else {
                moveLoader()
                return
            }
            self.meditaions.onNext(meditaions)
            moveLoader()
        }
    }
    
    var challengesResponse: ChallengesResponse? {
        didSet {
            guard let challenges = challengesResponse?.data?.results else {
                moveLoader()
                return
            }
            self.challenges.onNext(challenges)
            moveLoader()
        }
    }
    
    var coursesResponse: CoursesResponse? {
        didSet {
            guard let courses = coursesResponse?.data?.results else {
                moveLoader()
                return
            }
            self.courses.onNext(courses)
            moveLoader()
        }
    }
    
    var currentListenersResponse: CurrentListenersResponse? {
        didSet {
            guard let amount = currentListenersResponse?.data?.amount else {
                moveLoader()
                return
            }
            currentListenersAmount.onNext(amount)
            moveLoader()
        }
    }
    
    func getData() {
        dataMax = ModuleUserDefaults.getFeeling() != nil ? 6 : 5
        dataCount = 0
        loader = Loader.show(vc?.view)
        getRecommendations()
        getCollections()
        getFavoriteMeditaions()
        getChallenges()
        getCourses()
        getCurrentListeners()
    }
    
    func moveLoader() {
        dataCount += 1
        loader?.setProgress(100 * Float(dataCount / dataMax))
    }
    
    func getRecommendations(separate: Bool = false, page: Int = 1) {
        if separate {
            dataMax = 1
            dataCount = 0
        }
        if let feelingId = ModuleUserDefaults.getFeeling() {
            APIManager.shared.collections(type: 1, forFeeling: feelingId, page: page) { error, response in
                self.recommendationsResponse = response
            }
        }
    }
    
    func getCollections(page: Int = 1) {
        APIManager.shared.collections(type: 1, tags: 1, page: page) { error, response in
            self.collectionsResponse = response
        }
    }
    
    func getFavoriteMeditaions(page: Int = 1) {
        APIManager.shared.favoriteMeditaions(page: page) { error, response in
            self.meditaionsResponse = response
        }
    }
    
    func getChallenges(page: Int = 1) {
        APIManager.shared.challenges(page: page) { error, response in
            self.challengesResponse = response
        }
    }
    
    func getCourses(page: Int = 1) {
        APIManager.shared.courses(page: page) { error, response in
            self.coursesResponse = response
        }
    }
    
    func getCurrentListeners() {
        APIManager.shared.currentListeners() { error, response in
            self.currentListenersResponse = response
        }
    }
}
