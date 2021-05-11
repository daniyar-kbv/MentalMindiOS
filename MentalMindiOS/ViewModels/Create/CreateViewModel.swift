//
//  CreateViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import RxSwift

class CreateViewModel {
    var vc: CreateViewController?
    
    lazy var typesSubject = PublishSubject<[(key: Type, value: [Collection])]>()
    lazy var affirmations = PublishSubject<[Affirmation]>()
    
    var types: [(key: Type, value: [Collection])] = []
    var affirmationsResponse: AffirmationsResponse? {
        didSet {
            guard let affirmations = affirmationsResponse?.data?.results else { return }
            self.affirmations.onNext(affirmations)
        }
    }
    
    var loader: Loader?
    var gotFirst = false
    
    func getData() {
        loader = Loader.show(vc?.view)
        getTypes()
        getAffirmations()
    }
    
    func getTypes(page: Int = 1) {
        APIManager.shared.types(page: page) { error, response in
            self.loader?.setProgress(20)
            guard let types = response?.data?.results else {
                self.loader?.setProgress(100)
                return
            }
            let maxCount = types.count - 1
            var count = 0
            for type in types {
                guard let id = type.id else {
                    self.loader?.setProgress(100)
                    return
                }
                if id != 1 {
                    APIManager.shared.collections(type: id, page: page) {
                        guard let collection = $1?.data?.results else {
                            self.loader?.setProgress(100)
                            return
                        }
                        self.types.append((key: type, value: collection))
                        if self.types.count == maxCount {
                            self.typesSubject.onNext(self.types)
                        }
                        count += 1
                        self.loader?.setProgress(Float(20 + ((count / maxCount) * 80)))
                    }
                }
            }
        }
    }
    
    func getAffirmations() {
        APIManager.shared.affirmations() { error, response in
            self.loader?.setProgress(20)
            self.affirmationsResponse = response
        }
    }
}
