//
//  RemoteNotificationHandling.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import UIKit

@available(iOS, deprecated: 10.0)
public protocol iOS9AndBelowRemoteNotificationHandling: AnyObject {
    var didReceiveRemoteNotificationHandlers: WeakContainer<iOS9AndBelowRemoteNotificationPayloadHandling> { get }
}

public extension iOS9AndBelowRemoteNotificationHandling {
    // MARK: UIApplicationDelegate handler
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if let userInfo = launchOptions?[.remoteNotification] as? [AnyHashable : Any] {
            self.application(application, didReceiveRemoteNotification: userInfo)
        }
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .none {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        let payload = Payload(userInfo: userInfo)
        
        didReceiveRemoteNotificationHandlers.all.forEach { $0.didReceiveRemoteNotificationPayload(payload) }
        
        NotificationCenter.default.post(
            name: Notification.Name.RemoteNotificationHandling.didReceiveRemoteNotification,
            object: payload)
    }
}
