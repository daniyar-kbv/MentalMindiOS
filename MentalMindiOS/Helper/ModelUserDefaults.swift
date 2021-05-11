//
//  ModelUserDefaults.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

struct ModuleUserDefaults {
    private static let defaults = UserDefaults.standard
    
    static func setIsInitial(_ value: Bool){
        defaults.setValue(value, forKey: "isInitial")
    }
    
    static func getIsInitial() -> Bool{
        if let value = defaults.value(forKey: "isInitial") as? Int{
            return value == 1
        }
        return true
    }
    
    static func setIsLoggedIn(_ value: Bool){
        defaults.setValue(value, forKey: "isLoggedIn")
    }
    
    static func getIsLoggedIn() -> Bool{
        if let value = defaults.value(forKey: "isLoggedIn") as? Int{
            return value == 1
        }
        return false
    }
    
    static func setLanguage(_ value: Language) {
        defaults.setValue(value.rawValue, forKey: "language")
    }
    
    static func getLanguage() -> Language {
        if let language = Language(rawValue: defaults.value(forKey: "language") as? String ?? "ru") {
            return language
        }
        return .ru
    }
    
    static func setToken(_ value: String?) {
        defaults.setValue(value, forKey: "token")
    }
    
    static func getToken() -> String? {
        return defaults.value(forKey: "token") as? String
    }
    
    static func setFeeling(_ value: Int?) {
        defaults.setValue(value, forKey: "feeling")
    }
    
    static func getFeeling() -> Int? {
        return defaults.value(forKey: "feeling") as? Int
    }
    
    static func setBackgroundVolume(_ value: Float?) {
        defaults.setValue(value, forKey: "backgroundVolume")
    }
    
    static func getBackgroundVolume() -> Float? {
        return defaults.value(forKey: "backgroundVolume") as? Float
    }
    
    static func setNotificationDate(_ value: Date?){
        defaults.setValue(value, forKey: "notificationDate")
    }
    
    static func getNotificationDate() -> Date? {
        return defaults.value(forKey: "notificationDate") as? Date
    }
    
    static func setNotificationsWeekdays(_ object: [Weekday]?){
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: object?.map({ $0.rawValue }) as Any, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "notificationsWeekdays")
            defaults.synchronize()
        } catch {
        }
    }
    
    static func getNotificationsWeekdays() -> [Weekday]? {
        guard let decoded = defaults.data(forKey: "notificationsWeekdays") else {
            return nil
        }
        do {
            let decodedCount = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [Int?]
            return decodedCount?.map({ val in
                Weekday(rawValue: val) ?? .everyDay
            })
        } catch {
            print(error)
            return nil
        }
    }
    
    static func setUser(object: User?) {
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: object as Any, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "user")
            defaults.synchronize()
        } catch {
        }
    }

    static func getUser() -> User? {
        guard let decoded = defaults.data(forKey: "user") else {
            return nil
        }
        do {
            let decodedCount = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? User
            return decodedCount
        } catch {
            print(error)
            return nil
        }
    }
    
    static func setLevel(object: Level?) {
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: object as Any, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: "level")
            defaults.synchronize()
        } catch {
        }
    }

    static func getLevel() -> Level? {
        guard let decoded = defaults.data(forKey: "level") else {
            return nil
        }
        do {
            let decodedCount = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? Level
            return decodedCount
        } catch {
            print(error)
            return nil
        }
    }
    
    static func clear(){
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
}
