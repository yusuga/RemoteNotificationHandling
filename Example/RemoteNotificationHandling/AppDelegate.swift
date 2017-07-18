//
//  AppDelegate.swift
//  RemoteNotificationHandling
//
//  Created by yusuga on 07/18/2017.
//  Copyright (c) 2017 yusuga. All rights reserved.
//

import UIKit
import RemoteNotificationHandling

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        _ = RemoteNotificationManager.shared // setup
        return true
    }
    
    func clearApplicationIconBadge() {
        let badge = UIApplication.shared.applicationIconBadgeNumber
        RemoteNotificationUtility.clearApplicationIconBadge()
        NSLog("badge: \(badge) -> \(UIApplication.shared.applicationIconBadgeNumber)")
    }
}

extension AppDelegate { // RemoteNotificationDeviceTokenHandling
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NSLog("\(type(of: self)) \(#function)")
        RemoteNotificationManager.shared.deviceTokenHandler.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("\(type(of: self)) \(#function)")
        RemoteNotificationManager.shared.deviceTokenHandler.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
}

extension AppDelegate { // iOS9AndBelowRemoteNotificationHandling
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NSLog("\(type(of: self)) \(#function) launchOptions: \(String(describing: launchOptions))")
        clearApplicationIconBadge()
        RemoteNotificationManager.shared.iOS9AndBelowHandler?.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        NSLog("\(type(of: self)) \(#function)")
        RemoteNotificationManager.shared.iOS9AndBelowHandler?.application(application, didRegister: notificationSettings)
    }
    
    /// - note: Opening the app by tapping the icon will never give you information about previous notifications. It's only if you actually open the app via a notification that you will be able to access the notification data. (from [Stackoverflow](https://stackoverflow.com/a/13847840))
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NSLog("\(type(of: self)) \(#function)")
        RemoteNotificationManager.shared.iOS9AndBelowHandler?.application(application, didReceiveRemoteNotification: userInfo)
    }
}

extension AppDelegate {
    func applicationWillEnterForeground(_ application: UIApplication) {
        NSLog("\(type(of: self)) \(#function)")
        clearApplicationIconBadge()
    }
}
