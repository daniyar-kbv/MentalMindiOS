//
//  MeditationRateViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class MeditationRateViewController: BaseViewController {
    lazy var mainView = MeditationRateView()
    lazy var viewModel: MeditationRateViewModel = {
        let view = MeditationRateViewModel()
        view.vc = self
        return view
    }()
    lazy var disposeBag = DisposeBag()
    var superVc: MeditationDetailViewController?
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        mainView.ratingView.didFinishTouchingCosmos = { rating in
            self.viewModel.rateMeditation(star: Int(rating))
        }
        
        bind()
    }
    
    func bind() {
        viewModel.response.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                if self.superVc?.mainView.nextControllButton.subviews.contains(where: { $0.tag == 987 }) == false {
                    self.superVc?.currentMeditaion += 1
                }
            }
        }).disposed(by: disposeBag)
    }
}
