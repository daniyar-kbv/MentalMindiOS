//
//  Notification.swift
//  MentalMindiOS
//
//  Created by Dan on 1/18/21.
//

import Foundation
import UIKit

//{
//    "push_type_value": 261,
//    "aps": {
//        "alert": {
//            "body" = "\U0422\U0435\U0441\U0442 \U0430\U0444\U0444\U0438\U0440\U043c\U0430\U0446\U0438\U044f",
//            "title" = "\U0422\U0435\U0441\U0442 \U0430\U0444\U0444\U0438\U0440\U043c\U0430\U0446\U0438\U044f"
//        }
//    },
//    "google.c.sender.id": 122100448228,
//    "gcm.message_id": 1625058515668649,
//    "push_type": "meditation"
//    "google.c.a.e": 1
//}

class Notification {
    var aps: NotificationAps
    var pushType: NotificationType
    var pushTypeValue: String
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let apsDict = dictionary["aps"] as? [String: Any],
              let aps = NotificationAps(dictionary: apsDict),
              let pushTypeStr = dictionary["push_type"] as? String,
              let pushType = NotificationType(rawValue: pushTypeStr),
              let pushTypeValue = dictionary["push_type_value"] as? String
        else {
            print("\(String(describing: Self.self)) failed")
            return nil
        }
        
        self.aps = aps
        self.pushType = pushType
        self.pushTypeValue = pushTypeValue
    }
    
    func open() {
        switch pushType {
        case .meditation:
            guard let value = Int(pushTypeValue) else { return }
            APIManager.shared.meditationDetail(id: value) { error, response in
                guard let meditation = response?.data else { return }
                let collection = CollectionDetail(id: nil, name: nil, description: nil, type: nil, fileImage: nil, forFeeling: nil, tags: nil, meditations: [meditation], challenges: nil)
                let vc = MeditationDetailViewController(collection: collection, currentMeditation: 0)
                AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
            }
        case .affirmation:
            guard let value = Int(pushTypeValue) else { return }
            APIManager.shared.affirmationDetail(id: value) { error, response in
                let vc = AffirmationDetailViewController()
                vc.affirmation = response?.data
                AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
            }
        case .challenge:
            guard let value = Int(pushTypeValue) else { return }
            let vc = WideListViewController<Any>()
            vc.challengeId = value
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        case .collection:
            guard let value = Int(pushTypeValue) else { return }
            let vc = MeditationListViewController()
            vc.collectionId = value
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        case .pushLink:
            if let url = URL(string: pushTypeValue) {
                UIApplication.shared.open(url)
            }
        case .test:
            break
        }
    }
}

class NotificationAps {
    var alert: NotificationAlert
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let alertDict = dictionary["alert"] as? [AnyHashable: Any],
              let alert = NotificationAlert(dictionary: alertDict)
        else {
            print("\(String(describing: Self.self)) failed")
            return nil
        }
        self.alert = alert
    }
}

class NotificationAlert {
    var body: String
    var title: String
    
    init?(dictionary: [AnyHashable: Any]) {
        guard let body = dictionary["body"] as? String,
              let title = dictionary["title"] as? String
        else {
            print("\(String(describing: Self.self)) failed")
            return nil
        }
        self.body = body
        self.title = title
    }
}
