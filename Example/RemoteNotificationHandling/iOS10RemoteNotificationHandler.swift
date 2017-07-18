//
//  iOS10RemoteNotificationHandler.swift
//  RemoteNotificationHandling
//
//  Created by Yu Sugawara on 7/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UserNotifications
import RemoteNotificationHandling

class iOS10RemoteNotificationHandler: NSObject {
}

@available(iOS 10.0, *)
extension iOS10RemoteNotificationHandler: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        NSLog("\(type(of: self)) \(#function) {\nnotification.request.content: \(notification.request.content),\npayload: \(Payload(notification))\n}")
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        NSLog("\(type(of: self)) \(#function) {\nresponse.notification.request.content: \(response.notification.request.content),\npayload: \(Payload(response))\n}")                
        completionHandler()
    }
}
