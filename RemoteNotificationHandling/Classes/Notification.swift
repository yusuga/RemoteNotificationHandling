//
//  Notification.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import Foundation

extension Notification.Name {
    public struct RemoteNotificationDeviceTokenHandling {
        public static let didRegisterForRemoteNotifications = Notification.Name(rawValue: "RemoteNotificationDeviceTokenHandling.didRegisterForRemoteNotifications")
        public static let didFailToRegisterForRemoteNotifications = Notification.Name(rawValue: "RemoteNotificationDeviceTokenHandling.didFailToRegisterForRemoteNotifications")
    }
    
    public struct RemoteNotificationHandling {
        @available(iOS, deprecated: 10.0)
        public static let didReceiveRemoteNotification = Notification.Name(rawValue: "RemoteNotificationHandling.didReceiveRemoteNotification")
    }
}
