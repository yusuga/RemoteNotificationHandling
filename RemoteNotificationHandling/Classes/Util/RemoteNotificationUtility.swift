//
//  RemoteNotificationUtility.swift
//  Pods
//
//  Created by Yu Sugawara on 7/19/17.
//
//

import UserNotifications

public struct RemoteNotificationUtility {
    @available(iOS 10.0, *)
    public static func requestAuthorization(
        options: UNAuthorizationOptions = [.badge, .sound, .alert],
        application: UIApplication = UIApplication.shared) {
        
        UNUserNotificationCenter.current().requestAuthorization(
        options: options) { (granted, error) in
            DispatchQueue.main.async {
                if granted {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }
    
    @available(iOS, deprecated: 10.0)
    public static func registerUserNotificationSettings(
        _ settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert],
                                                                            categories: nil),
        application: UIApplication = UIApplication.shared) {
        
        application.registerUserNotificationSettings(settings)
    }
    
    public static func clearApplicationIconBadge(withApplication application: UIApplication = UIApplication.shared) {
        application.applicationIconBadgeNumber = 0
    }
}
