//
//  AppShared.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import FBSDKLoginKit


class AppShared {
    static let sharedInstance = AppShared()
    
    var appLoaded = false
    var keyWindow: UIWindow?
    var navigationController: UINavigationController!
    
    lazy var tabBarController = NavigationMenuBaseController()
    lazy var noInternetViewController = NoInternetViewController()
    
    var fcmToken: String? {
        didSet {
            updateFcmToken()
        }
    }
    
    lazy var feelingSubject = PublishSubject<Int>()
    var feelingId: Int? = ModuleUserDefaults.getFeeling() {
        didSet {
            guard let id = feelingId else { return }
            feelingSubject.onNext(id)
            ModuleUserDefaults.setFeeling(id)
        }
    }
    
    var selectedLanguage = ModuleUserDefaults.getLanguage() {
        didSet {
            ModuleUserDefaults.setLanguage(selectedLanguage)
        }
    }
    
    lazy var userSubject = PublishSubject<User>()
    var user: User? = ModuleUserDefaults.getUser() {
        didSet {
            guard let user = user else { return }
            ModuleUserDefaults.setUser(object: user)
            userSubject.onNext(user)
        }
    }
    var level: Level? = ModuleUserDefaults.getLevel() {
        didSet {
            guard let level = level else { return }
            ModuleUserDefaults.setLevel(object: level)
        }
    }
    var backgroundVolume: Float? = ModuleUserDefaults.getBackgroundVolume() {
        didSet {
            guard let volume = backgroundVolume else { return }
            ModuleUserDefaults.setBackgroundVolume(volume)
        }
    }
    var notificationsWeekdays = (key: ModuleUserDefaults.getNotificationDate(), value: ModuleUserDefaults.getNotificationsWeekdays()) {
        didSet {
            guard let date = notificationsWeekdays.key, let weekdays = notificationsWeekdays.value else { return }
            ModuleUserDefaults.setNotificationDate(date)
            ModuleUserDefaults.setNotificationsWeekdays(weekdays)
        }
    }
    
    lazy var selectedCountrySubject = PublishSubject<Country>()
    var selectedCountry: Country? {
        didSet {
            guard let country = selectedCountry else { return }
            selectedCountrySubject.onNext(country)
        }
    }
    
    lazy var selectedCitySubject = PublishSubject<City>()
    var selectedCity: City? {
        didSet {
            guard let city = selectedCity else { return }
            selectedCitySubject.onNext(city)
        }
    }
    
    var openNotification: Notification?
    
    func setNotifications() {
        guard let date = notificationsWeekdays.key, var weekdays = notificationsWeekdays.value else { return }
        
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Напоминание о медитации заголовок".localized
        content.body = "Напоминание о медитации описание".localized
        
        weekdays = weekdays.contains(.everyDay) ?
            [.mon, .tue, .wed, .thu, .fri, .sat, .sun] :
            notificationsWeekdays.value ?? []
        
        notificationCenter.removeAllPendingNotificationRequests()
        for weekday in weekdays {
            var dateComponents = DateComponents()
            let calendar = Calendar.current
                
            dateComponents.calendar = calendar

            dateComponents.weekday = weekday.rawValue
            dateComponents.hour = calendar.component(.hour, from: date)
            dateComponents.minute = calendar.component(.minute, from: date)
    
            let trigger = UNCalendarNotificationTrigger(
                     dateMatching: dateComponents, repeats: true)
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error) in
                if error != nil {
                    print(error as Any)
                }
            }
        }
    }
    
    func signOut() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        
        ModuleUserDefaults.setToken(nil)
        ModuleUserDefaults.setIsLoggedIn(false)
        ModuleUserDefaults.setNotificationsWeekdays(nil)
        ModuleUserDefaults.setNotificationDate(nil)
        
        feelingId = nil
        level = nil
        notificationsWeekdays = (key: nil, value: nil)
        selectedCountry = nil
        user = nil
        
        let window = Global.keyWindow
        keyWindow = window
        let vc = ChooseAuthViewController()
        vc.authView.backButton.isHidden = true
        navigationController.pushViewController(vc, animated: false)
        navigationController.viewControllers.removeAll(where: { $0 != vc })
        
        window?.rootViewController = AppShared.sharedInstance.navigationController
        window?.makeKeyAndVisible()
        
        AccessToken.current = nil
        Profile.current = nil
    }
    
    func updateFcmToken() {
        guard let fcmToken = fcmToken,
              ModuleUserDefaults.getFcmToken() != fcmToken &&
              ModuleUserDefaults.getIsLoggedIn() else { return }
        ModuleUserDefaults.setFcmToken(fcmToken)
        APIManager.shared.updateProfile(fcmToken: fcmToken) { error, response in
            guard let user = response?.data else { return }
            self.user = user
        }
    }
}
