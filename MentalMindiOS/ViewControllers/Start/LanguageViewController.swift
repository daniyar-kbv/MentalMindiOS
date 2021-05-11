//
//  LanguageViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit

class LanguageViewController: BaseViewController {
    lazy var languageView = LanguageView()
    
    override func loadView() {
        super.loadView()
        
        view = languageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        for view in languageView.stack.arrangedSubviews as! [CustomButton] {
            view.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender {
        case languageView.kazakhButton:
            AppShared.sharedInstance.selectedLanguage = .kz
        case languageView.russianButton:
            AppShared.sharedInstance.selectedLanguage = .ru
        default:
            break
        }
        
        navigationController?.pushViewController(OnBoardingViewController(), animated: true)
    }
}
