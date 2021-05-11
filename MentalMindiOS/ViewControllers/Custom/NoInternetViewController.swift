//
//  NoInternetViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class NoInternetViewController: BaseViewController {
    lazy var internetView = NoInternetView()
    var isNavigationBarHidden: Bool!
    
    override func loadView() {
        super.loadView()
        
        view = internetView
    }
}
