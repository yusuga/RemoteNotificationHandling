//
//  DeviceToken.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import Foundation

public struct DeviceToken {
    public let data: Data
    public var string: String {
        return data.map { String(format: "%.2hhx", $0) }.joined()
    }
    
    public init(data: Data) {
        self.data = data
    }
}

public enum DeviceTokenResult {
    case success(DeviceToken)
    case failure(Error)
}
