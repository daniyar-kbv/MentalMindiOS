//
//  PromocodeViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import RxSwift

class PromocodeViewController: BaseViewController {
    lazy var mainView = PromocodeView()
    lazy var viewModel = PromocodeViewModel()
    lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .darkContent
        hideKeyboardWhenTappedAround()
        mainView.setTitle("Промокод".localized)
        
        mainView.textField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        mainView.bottomButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        bind()
    }
    
    func bind() {
        viewModel.data.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.showAlert(
                    title: "Поздравляем!".localized,
                    messsage: "Ваш промокод успешно применен! Теперь Вы можете пользоваться полным функционалом приложения в течении 7 дней!".localized,
                    actions: [(
                        key: "Отлично".localized,
                        value: { action in
                            self.navigationController?.popViewController(animated: true)
                        }
                    )]
                )
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func fieldChanged() {
        mainView.bottomButton.isActive = !mainView.textField.isEmpty()
    }
    
    @objc func buttonTapped() {
        if let text = mainView.textField.text {
            viewModel.promocode(promocode: text)
        }
    }
}
