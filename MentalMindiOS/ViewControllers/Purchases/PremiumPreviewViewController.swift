//
//  PremiumPreviewViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import UIKit

class PremiumPreviewViewController: BaseViewController {
    lazy var mainView = PremiumPreviewView()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        mainView.privacyButton.onTap = policyTapped(_:)
        mainView.bottomButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func policyTapped(_ button: PolicyButton) {
        mainView.bottomButton.isActive = button.isActive
    }
    
    @objc func buttonTapped() {
        navigationController?.pushViewController(PremiumPurchaseViewController(), animated: true)
    }
}
