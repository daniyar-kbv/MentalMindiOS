//
//  ReachabilityHandler.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Reachability

//Reachability
//declare this property where it won't go out of scope relative to your listener
fileprivate var reachability: Reachability!

protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool)
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
}

// Declaring default implementation of adding/removing observer
extension ReachabilityObserverDelegate {
    
    /** Subscribe on reachability changing */
    func addReachabilityObserver() throws {
        reachability = try Reachability()
        
        reachability.whenReachable = { [weak self] reachability in
            self?.reachabilityChanged(true)
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            self?.reachabilityChanged(false)
        }
        
        try reachability.startNotifier()
    }
    
    /** Unsubscribe */
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}

class ReachabilityHandler: ReachabilityObserverDelegate {
    let shared = AppShared.sharedInstance
    //MARK: Lifecycle

    required init() {
        try? addReachabilityObserver()
    }

    deinit {
        removeReachabilityObserver()
    }

    //MARK: Reachability
    
    func reachabilityChanged(_ isReachable: Bool) {
        print("isReachable: \(isReachable)")
        let nav = AppShared.sharedInstance.navigationController
        let vc = AppShared.sharedInstance.noInternetViewController
        if isReachable && vc.navigationController != nil{
            nav?.popViewController(animated: false)
            UIApplication.topViewController()?.viewDidLoad()
        } else if !isReachable && vc.navigationController == nil{
            UIApplication.topViewController()?.dismiss(animated: false, completion: {
                nav?.pushViewController(vc, animated: false)
            })
        }
    }
}


