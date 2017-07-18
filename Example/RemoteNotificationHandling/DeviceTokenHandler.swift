//
//  DeviceTokenHandler.swift
//  RemoteNotificationHandling
//
//  Created by Yu Sugawara on 7/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import RemoteNotificationHandling

struct DeviceTokenHandler: RemoteNotificationDeviceTokenHandling {
    func didRegisterForRemoteNotifications(result: DeviceTokenResult) {
        switch result {
        case .success(let deviceToken):
            NSLog("\(type(of: self)) \(#function) success deviceToken.string: \(deviceToken.string)")
        case .failure(let error):
            NSLog("\(type(of: self)) \(#function) failure error: \(error)")
        }
    }
}
