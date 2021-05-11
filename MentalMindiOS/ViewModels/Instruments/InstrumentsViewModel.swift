//
//  InstrumentsViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import RxSwift

class InstrumentsViewModel {
    var vc: InstrumentsViewController?
    
    lazy var tagsSubject = PublishSubject<[(key: Tag, value: [Collection])]>()
    
    var tags: [(key: Tag, value: [Collection])] = []
    
    func getTags(page: Int = 1) {
        let loader = Loader.show(vc?.view)
        APIManager.shared.tags(page: page) { error, response in
            loader.setProgress(20)
            guard let tags = response?.data?.results else {
                loader.setProgress(100)
                return
            }
            let maxCount = tags.count
            var count = 0
            for tag in tags {
                APIManager.shared.collections(type: 1, tags: tag.id, page: page) {
                    guard let collection = $1?.data?.results else {
                        loader.setProgress(100)
                        return
                    }
                    self.tags.append((key: tag, value: collection))
                    if self.tags.count == maxCount {
                        self.tagsSubject.onNext(self.tags)
                    }
                    count += 1
                    loader.setProgress(Float(20 + ((count / maxCount) * 80)))
                }
            }
        }
    }
}
