//
//  Preference.swift
//  SharedDefaults
//
//  Created by arshak ‎ on 16.04.23.
//

import Foundation

public class Preference<T> {
    private let storage: Storage
    public let key: PreferenceKey
    public var value: T {
        get {
            return storage.get(key.rawValue, defaultValue: key.defaultValue as! T)
        }
        set {
            storage.set(newValue, forKey: key.rawValue)
        }
    }
    
    public init(storage: Storage, key: PreferenceKey) {
        self.storage = storage
        self.key = key
    }
}

public enum PreferenceKey: String, CaseIterable {
    case enableHapticFeedback
    case enableAudioFeedback
    case colonCalloutCharacters
    case commaCalloutCharacters
    case enableSync
    case enableAutocapitalization
    
    var defaultValue: Any {
        switch self {
        case .enableHapticFeedback:
            return true
        case .enableAudioFeedback:
            return true
        case .colonCalloutCharacters:
            return "։,՞֊՛՝՜"
        case .commaCalloutCharacters:
            return ",«»—՟()՚"
        case .enableSync:
            return false
        case .enableAutocapitalization:
            return true
        }
    }
}
