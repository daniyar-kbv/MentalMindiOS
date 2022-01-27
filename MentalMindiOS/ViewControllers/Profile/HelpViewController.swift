//
//  HelpViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import RxSwift

class HelpViewController: BaseViewController {
    lazy var mainView = HelpView()
    lazy var viewModel = HelpViewModel()
    lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.setTitle("Помощь".localized)
        statusBarStyle = .darkContent
        hideKeyboardWhenTappedAround()
        
        mainView.textView.onChange = onTextChange
        mainView.bottomButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        bind()
    }
    
    @objc func buttonTapped() {
        viewModel.chelp(text: mainView.textView.text)
    }
    
    func onTextChange() {
        mainView.bottomButton.isActive = !mainView.textView.isEmpty
    }
    
    func bind() {
        viewModel.success.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.showAlert(
                    title: "Мы все проверим".localized,
                    messsage: "Письмо успешно отправлено, ответ придет Вам на E-mail указанный при регистрации".localized,
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
}
