//
//  FAQViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 15.12.2020.
//

import Foundation
import UIKit
import RxSwift

class FAQViewController: InnerViewController<FAQViewModel> {
    lazy var mainView = FAQView()
    lazy var disposeBag = DisposeBag()
    
    var faqs: [FAQ]? {
        didSet {
            mainView.faqs = faqs
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.setTitle("FAQ".localized)
        mainView.barStyle = .darkContent
        viewModel = FAQViewModel()
        
        bind()
    }
    
    func bind() {
        viewModel?.faqs.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.faqs = object
            }
        }).disposed(by: disposeBag)
    }
}
