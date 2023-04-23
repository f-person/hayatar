//
//  Storage.swift
//  SharedDefaults
//
//  Created by arshak ‎ on 16.04.23.
//

import Foundation

public struct Storage {
    public var local: UserDefaults
    public var cloud: NSUbiquitousKeyValueStore?
    public var shouldUseCloud: Bool
    
    public init(local: UserDefaults, cloud: NSUbiquitousKeyValueStore?, shouldUseCloud: Bool) {
        self.local = local
        self.cloud = cloud
        self.shouldUseCloud = shouldUseCloud
    }
    
    public func get<T>(_ key: String, defaultValue: T) -> T {
        if shouldUseCloud, let cloudValue = cloud?.object(forKey: key) as? T {
            return cloudValue
        } else if let localValue = local.object(forKey: key) as? T {
            return localValue
        } else {
            return defaultValue
        }
    }
    
    public func set<T>(_ value: T, forKey key: String) {
        local.set(value, forKey: key)
        if shouldUseCloud {
            cloud?.set(value, forKey: key)
        }
    }
}
