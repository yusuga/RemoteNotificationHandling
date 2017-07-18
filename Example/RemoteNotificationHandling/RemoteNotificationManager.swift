//
//  RemoteNotificationManager.swift
//  RemoteNotificationHandling
//
//  Created by Yu Sugawara on 7/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RemoteNotificationHandling
import UserNotifications

struct RemoteNotificationManager {
    static let shared = RemoteNotificationManager()
    private init() {
        if #available(iOS 10.0, *) {
            let handler = iOS10RemoteNotificationHandler()
            
            // Use the delegate object to respond to selected actions or to hide notifications while your app is in the foreground. To guarantee that your app is able to respond to actionable notifications, you must set the value of this property before your app finishes launching. For example, this means assigning a delegate object to this property in an iOS app’s application(_:willFinishLaunchingWithOptions:) or            application(_:didFinishLaunchingWithOptions:) method.
            // https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649522-delegate
            UNUserNotificationCenter.current().delegate = handler
            
            iOS10Handler = handler
        } else {
            iOS9AndBelowHandler = iOS9AndBelowRemoteNotificationHandler()
        }
    }
    
    let deviceTokenHandler = DeviceTokenHandler()
    private(set) var iOS10Handler: iOS10RemoteNotificationHandler?
    private(set) var iOS9AndBelowHandler: iOS9AndBelowRemoteNotificationHandler?
}
