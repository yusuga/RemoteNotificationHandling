//
//  WeakContainer.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import Foundation

public struct WeakContainer<T: AnyObject> {
    public init() {}
    
    /// Did not specify T to allow any type to be added.
    private let weakTable = NSHashTable<T>.weakObjects()
    
    public func add(_ value: T) {
        weakTable.add(value)
    }
    
    public func remove(_ value: T) {
        weakTable.remove(value)
    }
    
    var all: [T] {
        return weakTable.allObjects
    }
}
