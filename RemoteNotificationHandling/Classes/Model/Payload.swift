//
//  Payload.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import Foundation
import UserNotifications

/// [Payload Key Reference](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html)
public struct Payload {
    public init(userInfo: [AnyHashable : Any]) {
        self.userInfo = userInfo
    }
    
    public let userInfo: [AnyHashable : Any]
    public var aps: [AnyHashable : Any]? { return userInfo["aps"] as? [AnyHashable : Any] }
    public var alert: Alert? { return Alert(any: aps?["alert"]) }
    public var badge: Int? { return aps?["badge"] as? Int }
    public var sound: String? { return aps?["sound"] as? String }
    public var contentAvailable: Int? { return aps?["content-available"] as? Int }
    public var category: String? { return aps?["category"] as? String }
    public var threadID: String? { return aps?["thread-id"] as? String }
    
    public class Alert: NSObject {
        fileprivate init?(any: Any?) {
            switch any {
            case let title as String:
                self.properties = ["title" : title]
            case let properties as [AnyHashable : Any]:
                self.properties = properties
            default:
                assertionFailure("Unsupported type: \(type(of: any))")
                return nil
            }
        }
        
        public let properties: [AnyHashable : Any?]
        public var title: String? { return properties["title"] as? String }
        public var body: String? { return properties["body"] as? String }
        public var titleLocKey: String? { return properties["title-loc-key"] as? String }
        public var titleLocArgs: [String]? { return properties["title-loc-args"] as? [String] }
        public var locKey: String? { return properties["loc-key"] as? String }
        public var locArgs: [String]? { return properties["loc-args"] as? [String] }
        public var launchImage: String? { return properties["launch-image"] as? String }
    }
}

@available(iOS 10.0, *)
public extension Payload {
    init(_ response: UNNotificationResponse) {
        self.init(response.notification)
    }
    
    init(_ notification: UNNotification) {
        self.init(notification.request)
    }
    
    init(_ request: UNNotificationRequest) {
        self.init(request.content)
    }
    
    init(_ content: UNNotificationContent) {
        self.init(userInfo: content.userInfo)
    }
}
