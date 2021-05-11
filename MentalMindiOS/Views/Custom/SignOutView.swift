//
//  SignOutView.swift
//  MentalMindiOS
//
//  Created by Dan on 4/1/21.
//

import Foundation
import UIKit

class SignOutView: UIView {
    lazy var button: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customRed
        view.setTitle("Выйти".localized, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(17), weight: .medium)
        view.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    @objc func signOutTapped() {
        UIApplication.topViewController()?.showAlert(
            title: "Вы точно хотите выйти?".localized,
            actions: [
                (
                    key: "Выйти".localized,
                    value: { action in
                        let notificationCenter = UNUserNotificationCenter.current()
                        notificationCenter.removeAllPendingNotificationRequests()
                        
                        ModuleUserDefaults.setToken(nil)
                        ModuleUserDefaults.setIsLoggedIn(false)
                        ModuleUserDefaults.setNotificationsWeekdays(nil)
                        ModuleUserDefaults.setNotificationDate(nil)
                        
                        AppShared.sharedInstance.feelingId = nil
                        AppShared.sharedInstance.level = nil
                        AppShared.sharedInstance.notificationsWeekdays = (key: nil, value: nil)
                        AppShared.sharedInstance.selectedCountry = nil
                        AppShared.sharedInstance.user = nil
                        
                        let window = Global.keyWindow
                        AppShared.sharedInstance.keyWindow = window
                        let vc = ChooseAuthViewController()
                        vc.authView.backButton.isHidden = true
                        AppShared.sharedInstance.navigationController.pushViewController(vc, animated: false)
                        AppShared.sharedInstance.navigationController.viewControllers.removeAll(where: { $0 != vc })
                        window?.rootViewController = AppShared.sharedInstance.navigationController
                        window?.makeKeyAndVisible()
                    }
                ),
                (
                    key: "Отмена".localized,
                    value: { _ in }
                )
            ]
        )
    }
    
    func setUp() {
        addSubViews([button])
        
        button.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.bottom.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
