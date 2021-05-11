//
//  NavigationBaseController.swift
//  GOALSTER
//
//  Created by Daniyar on 8/11/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class NavigationMenuBaseController: UITabBarController {
    lazy var disposeBag = DisposeBag()
    lazy var tabItems: [TabItem] = [.main, .instruments, .create, .profile]
    
    var customTabBar: TabNavigationMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        loadTabBar()
    }
    
    private func loadTabBar() {
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        
        self.selectedIndex = 0
    }
    
    private func setupCustomTabBar(_ items: [TabItem], completion: @escaping ([UIViewController]) -> Void){
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        
        tabBar.isHidden = true
        
        customTabBar = TabNavigationMenu(menuItems: items, frame: frame)
        customTabBar.itemTapped = self.changeTab
        
        customTabBar.layer.shadowRadius = 5
        customTabBar.layer.shadowColor = UIColor.black.cgColor
        customTabBar.layer.shadowOpacity = 0.15
        
        view.addSubview(customTabBar)
        
        customTabBar.snp.makeConstraints({
            $0.left.right.bottom.width.equalTo(tabBar)
            $0.height.equalTo(StaticSize.tabBarHeight)
        })
        
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        
        view.layoutIfNeeded()
        completion(controllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
        (viewControllers?[tab] as? BaseViewController)?.setStatusBar()
    }
    
    func toTab(tab: Int, completion: ((Bool) -> Void)? = nil) {
        customTabBar.switchTab(from: customTabBar.activeItem, to: tab, completion: completion)
    }
    
    func reloadOnLanguageChange() {
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        customTabBar.deactivateTab(tab: 0)
        customTabBar.activateTab(tab: 3)
        selectedIndex = 3
    }
}

extension NavigationMenuBaseController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarAnimatedTransitioning()
    }
}

final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

        destination.alpha = 0.0
        destination.transform = .init(scaleX: 1.5, y: 1.5)
        transitionContext.containerView.addSubview(destination)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
            destination.transform = .identity
        }, completion: { transitionContext.completeTransition($0) })
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }

}
