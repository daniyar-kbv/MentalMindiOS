//
//  AppDelegate.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import UIKit
import AlamofireNetworkActivityLogger
import GoogleSignIn
import FBSDKCoreKit
import VK_ios_sdk
import PushNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let reachibilityHandler = ReachabilityHandler()
    let beamsClient = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        if let instanceId = Bundle.main.getSecret(key: "Beams Instance Id") as? String {
            beamsClient.start(instanceId: instanceId)
            print("Beams Client started")
        }
        
        beamsClient.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        beamsClient.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let remoteNotificationType = self.beamsClient.handleNotification(userInfo: userInfo)
        if remoteNotificationType == .ShouldIgnore {
            return
        }
    }
    
    //Present in app
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        let notification = Notification(dictionary: userInfo)
        UIApplication.topViewController()?.showAlert(
            title: notification?.aps.alert.title,
            messsage: notification?.aps.alert.body,
            actions: [(
                key: "Ок".localized,
                value: { action in
                    notification?.open()
                }
            )]
        )
    }

    //On tap
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        let notification = Notification(dictionary: userInfo)
        notification?.open()
    }
}
    
extension AppDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        
        GIDSignIn.sharedInstance().handle(url)
        
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        
        GIDSignIn.sharedInstance().handle(url)
        
        return true
    }
}

