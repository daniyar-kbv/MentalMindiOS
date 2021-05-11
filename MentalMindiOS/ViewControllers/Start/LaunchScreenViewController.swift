//
//  LaunchScreenViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import RxSwift

class LaunchScreenViewController: UIViewController {
    lazy var launchView = LaunchScreenView()
    lazy var viewModel = LaunchScreenViewModel()
    lazy var disposeBag = DisposeBag()
    var timer: Timer?
    lazy var initialTimerValue: Int = 1
    lazy var timerValue: Int = initialTimerValue
    var gotData: Bool = false
    var popGesture = false
    
    override func loadView() {
        super.loadView()
        
        view = launchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        if ModuleUserDefaults.getIsLoggedIn() {
            viewModel.subscriptionStatus()
        } else {
            gotData = true
        }
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func bind() {
        viewModel.data.subscribe(onNext: { object in
            DispatchQueue.main.async {
                let user = AppShared.sharedInstance.user
                let showAlert = (user?.getIsPreimium() ?? false) && !object.getIsPreimium() && (object.isSubscriptionExpired ?? false)
                user?.isPaid = object.isPaid
                user?.isActive = object.isActive
                user?.isPremium = object.isPremium
                user?.isTrial = object.isTrial
                AppShared.sharedInstance.user = user
                if showAlert {
                    UIApplication.topViewController()?.showAlert(title: "Срок действия вашей подписки истек".localized)
                }
                self.gotData = true
//                self.toMain()
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        runTimer()
        
        AppShared.sharedInstance.navigationController.interactivePopGestureRecognizer?.addTarget(self, action: #selector(navigationControllerPopGestureRecognizerAction(_:)))
        AppShared.sharedInstance.navigationController.delegate = self
        AppShared.sharedInstance.navigationController.interactivePopGestureRecognizer?.isEnabled = false
        AppShared.sharedInstance.navigationController.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timerValue == 0{
                self.toMain()
                timer.invalidate()
                return
            }
            self.timerValue -= 1
        }
    }
    
    func toMain() {
//        if gotData && timerValue == 0 {
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = .fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            var vc: UIViewController
            if ModuleUserDefaults.getIsInitial() {
//                vc = LanguageViewController()
                vc = OnBoardingViewController()
            } else if !ModuleUserDefaults.getIsLoggedIn() {
                let chooseVc = ChooseAuthViewController()
                chooseVc.authView.backButton.isHidden = true
                vc = chooseVc
            } else {
                vc = NavigationMenuBaseController()
                AppShared.sharedInstance.tabBarController = vc as! NavigationMenuBaseController
            }
            navigationController?.pushViewController(vc, animated: false)
            AppShared.sharedInstance.appLoaded = true
//        }
    }
}

extension LaunchScreenViewController: UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        AppShared.sharedInstance.navigationController.interactivePopGestureRecognizer?.isEnabled =
            !(
                AppShared.sharedInstance.navigationController.viewControllers.last is NavigationMenuBaseController ||
                AppShared.sharedInstance.navigationController.viewControllers.last is ChooseAuthViewController
            )
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if !popGesture {
            setStatusBar()
        }
    }
    
    @objc func navigationControllerPopGestureRecognizerAction(_ sender: UIGestureRecognizer) {
        switch sender.state {
        case .began:
            popGesture = true
        case .cancelled, .failed, .ended:
            setStatusBar()
            popGesture = false
        default:
            break
        }
    }
    
    func setStatusBar() {
        if let vc = AppShared.sharedInstance.navigationController.viewControllers.last as? BaseViewController {
            vc.setStatusBar()
        } else if let vcNavigation = AppShared.sharedInstance.navigationController.viewControllers.last as? NavigationMenuBaseController, let vc = vcNavigation.viewControllers?[vcNavigation.selectedIndex] as? BaseViewController {
            vc.setStatusBar()
        }
    }
}

