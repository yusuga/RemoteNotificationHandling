//
//  RemoteNotificationPayloadHandling.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import Foundation

@available(iOS, deprecated: 10.0)
public protocol iOS9AndBelowRemoteNotificationPayloadHandling {
    func didReceiveRemoteNotificationPayload(_ payload: Payload)
}
