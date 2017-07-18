//
//  iOS9AndBelowRemoteNotificationHandler.swift
//  RemoteNotificationHandling
//
//  Created by Yu Sugawara on 7/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import RemoteNotificationHandling

class iOS9AndBelowRemoteNotificationHandler: iOS9AndBelowRemoteNotificationHandling {
    init() {
        didReceiveRemoteNotificationHandlers.add(self)
    }
    
    let didReceiveRemoteNotificationHandlers = WeakContainer<iOS9AndBelowRemoteNotificationPayloadHandling>()
}

extension iOS9AndBelowRemoteNotificationHandler: iOS9AndBelowRemoteNotificationPayloadHandling {
    func didReceiveRemoteNotificationPayload(_ payload: Payload) {
        NSLog("\(type(of: self)) \(#function) {\napplicationState: \(UIApplication.shared.applicationState.rawValue)\npayload: \(payload)\n}")
        
        let alert = UIAlertController(
            title: payload.alert?.title ?? "Received Payload",
            message: payload.alert?.body ?? String(describing: payload.userInfo),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true)
    }
}
