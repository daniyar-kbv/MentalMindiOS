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
import PushNotifications


class AppShared {
    static let sharedInstance = AppShared()
    
    var appLoaded = false
    
    var keyWindow: UIWindow?
    var navigationController: UINavigationController!
    lazy var tabBarController = NavigationMenuBaseController()
    lazy var noInternetViewController = NoInternetViewController()
    
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
            for language in Language.allCases {
                language == selectedLanguage ?
                    try? PushNotifications.shared.addDeviceInterest(interest: language.interestName) :
                    try? PushNotifications.shared.removeDeviceInterest(interest: language.interestName)
            }
            
        }
    }
    
    lazy var userSubject = PublishSubject<User>()
    var user: User? = ModuleUserDefaults.getUser() {
        didSet {
            guard let user = user, let email = user.email else { return }
            ModuleUserDefaults.setUser(object: user)
            try? PushNotifications.shared.addDeviceInterest(interest: email)
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
}
