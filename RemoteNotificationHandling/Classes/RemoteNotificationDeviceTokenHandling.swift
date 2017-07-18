//
//  RemoteNotificationDeviceTokenHandling.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import Foundation

public protocol RemoteNotificationDeviceTokenHandling {
    func didRegisterForRemoteNotifications(result: DeviceTokenResult)
}

public extension RemoteNotificationDeviceTokenHandling {
    // MARK: UIApplicationDelegate handler
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceToken = DeviceToken(data: deviceToken)
        
        didRegisterForRemoteNotifications(result: .success(deviceToken))
        
        NotificationCenter.default.post(
            name: Notification.Name.RemoteNotificationDeviceTokenHandling.didRegisterForRemoteNotifications,
            object: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        didRegisterForRemoteNotifications(result: .failure(error))
        
        NotificationCenter.default.post(
            name: Notification.Name.RemoteNotificationDeviceTokenHandling.didFailToRegisterForRemoteNotifications,
            object: error)
    }
    
    // MARK: -
    
    func didRegisterForRemoteNotifications(result: DeviceTokenResult) {}
}
