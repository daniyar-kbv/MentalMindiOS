//
//  Notification.swift
//  MentalMindiOS
//
//  Created by Dan on 1/18/21.
//

import Foundation
import UIKit

class Notification {
    var aps: NotificationAps
    var data: NotificationData
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let apsDict = dictionary["aps"] as? [AnyHashable: Any],
              let aps = NotificationAps(dictionary: apsDict),
              let dataDict = dictionary["data"] as? [AnyHashable: Any],
              let data = NotificationData(dictionary: dataDict)
        else {
            return nil
        }
        self.aps = aps
        self.data = data
    }
    
    func open() {
        switch data.pushType {
        case .meditation:
            guard let value = data.pushTypeValue as? Int else { return }
            APIManager.shared.meditationDetail(id: value) { error, response in
                guard let meditation = response?.data else { return }
                let vc = MeditationDetailViewController()
                vc.collection = CollectionDetail(id: nil, name: nil, description: nil, type: nil, fileImage: nil, forFeeling: nil, tags: nil, meditations: [meditation], challenges: nil)
                vc.currentMeditaion = 0
                AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
            }
        case .affirmation:
            guard let value = data.pushTypeValue as? Int else { return }
            APIManager.shared.affirmationDetail(id: value) { error, response in
                let vc = AffirmationDetailViewController()
                vc.affirmation = response?.data
                AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
            }
        case .challenge:
            guard let value = data.pushTypeValue as? Int else { return }
            let vc = WideListViewController<Any>()
            vc.challengeId = value
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        case .collection:
            guard let value = data.pushTypeValue as? Int else { return }
            let vc = MeditationListViewController()
            vc.collectionId = value
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        case .pushLink:
            guard let value = data.pushTypeValue as? String else { return }
            if let url = URL(string: value) {
                UIApplication.shared.open(url)
            }
        }
    }
}

class NotificationAps {
    var alert: NotificationAlert
    var contentAvailable: Int
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let alertDict = dictionary["alert"] as? [AnyHashable: Any],
              let alert = NotificationAlert(dictionary: alertDict),
              let contentAvailable = dictionary["content-available"] as? Int
        else {
            return nil
        }
        self.alert = alert
        self.contentAvailable = contentAvailable
    }
}

class NotificationAlert {
    var body: String
    var title: String
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let body = dictionary["body"] as? String,
              let title = dictionary["title"] as? String
        else {
            return nil
        }
        self.body = body
        self.title = title
    }
}

class NotificationData {
    var pushType: NotificationType
    var pushTypeValue: Any
    var pusher: NotificationPusher
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let pushTypeString = dictionary["push_type"] as? String,
              let pushType = NotificationType(rawValue: pushTypeString),
              let pusherDict = dictionary["pusher"] as? [AnyHashable: Any],
              let pusher = NotificationPusher(dictionary: pusherDict)
        else {
            return nil
        }
        self.pushType = pushType
        self.pusher = pusher
        switch pushType {
        case .pushLink:
            guard let pushValue = dictionary["push_type_value"] as? String else { return nil }
            self.pushTypeValue = pushValue
        default:
            guard let pushValue = dictionary["push_type_value"] as? Int else { return nil }
            self.pushTypeValue = pushValue
        }
    }
}


class NotificationPusher {
    var instanceId: String
    var publishId: String
    var userShouldIgnore: Bool
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let instanceId = dictionary["instanceId"] as? String,
              let publishId = dictionary["publishId"] as? String,
              let userShouldIgnore = dictionary["userShouldIgnore"] as? Bool
        else {
            return nil
        }
        self.instanceId = instanceId
        self.publishId = publishId
        self.userShouldIgnore = userShouldIgnore
    }
}
