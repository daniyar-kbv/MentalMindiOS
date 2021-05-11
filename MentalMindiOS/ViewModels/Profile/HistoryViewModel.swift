//
//  HistoryVIewModel.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import RxSwift

class HistoryViewModel: BaseViewModelDelegate {
    lazy var records = PublishSubject<[HistoryRecord]>()
    var superVc: HistoryViewController?
    
    var response: GetHistoryResponse? {
        didSet {
            guard let records = response?.data?.results else { return }
            self.records.onNext(records)
        }
    }
    
    func getData() {
        guard let date = superVc?.date else { return }
        APIManager.shared.getHistory(date: date) { error, response in
            self.response = response
        }
    }
}
