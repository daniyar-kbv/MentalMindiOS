//
//  BaseViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 17.12.2020.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var statusBarStyle: UIStatusBarStyle = .darkContent
    
    func setStatusBar() {
        UIApplication.shared.statusBarStyle = statusBarStyle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.subviews.first(where: { $0 is Loader })?.removeFromSuperview()
    }
}

protocol InnerViewControllerDelegate {
    associatedtype T: BaseViewModelDelegate
    
    var viewModel: T? { get set }
}

class InnerViewController<T: BaseViewModelDelegate>: BaseViewController, InnerViewControllerDelegate {
    typealias T = T
    
    var viewModel: T?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.getData()
    }
}
