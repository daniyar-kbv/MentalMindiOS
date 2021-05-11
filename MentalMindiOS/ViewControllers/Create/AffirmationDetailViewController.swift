//
//  AffirmationDetailViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import LinkPresentation

class AffirmationDetailViewController: BaseViewController {
    lazy var mainView = AffirmationDetailView()
    
    var affirmation: Affirmation? {
        didSet {
            mainView.affirmation = affirmation
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
    }
}
