//
//  WeakContainer.swift
//  Pods
//
//  Created by Yu Sugawara on 7/18/17.
//
//

import Foundation

public struct WeakContainer<T> {
    public init() {}
    
    /// Did not specify T to allow any type to be added.
    private let weakTable = NSHashTable<AnyObject>.weakObjects()
    
    public func add(_ value: T) {
        weakTable.add(value as AnyObject)
        print("value: \(value)")
        print("weakTable: \(weakTable.allObjects)")
    }
    
    public func remove(_ value: T) {
        weakTable.remove(value as AnyObject)
    }
    
    var all: [T] {
        return weakTable.allObjects as! [T]
    }
}
