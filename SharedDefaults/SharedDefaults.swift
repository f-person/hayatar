//
//  SharedDefaults.swift
//  SharedDefaults
//
//  Created by arshak ‎ on 07.04.23.
//

import Foundation

public struct SharedDefaults {
    public static let appGroupID = "group.dev.fperson.hayatar.shared"
    
    public static var localStore: UserDefaults? {
        UserDefaults(suiteName: appGroupID)
    }
    
    private static var iCloudStore: NSUbiquitousKeyValueStore? {
        if FileManager.default.ubiquityIdentityToken != nil {
            return NSUbiquitousKeyValueStore.default
        } else {
            return nil
        }
    }
    
    public static let enableHapticFeedbackKey = "enableHapticFeedback"
    public static let enableAudioFeedbackKey = "enableAudioFeedback"
    public static let colonCalloutCharactersKey = "colonCallouts"
    public static let commaCalloutCharactersKey = "commaCallouts"
    
    public static let defaultEnableHapticFeedback = true
    public static let defaultEnableAudioFeedback = true
    public static let defaultColonCalloutCharacters = "։,՞֊՛՝՜"
    public static let defaultCommaCalloutCharacters = ",«»—՟()՚"
    
    private static let enableSyncKey = "enableSync"
    public static var enableSync: Bool {
        set {
            if newValue {
                syncAllPreferencesToCloud()
            }
            iCloudStore?.set(newValue, forKey: enableSyncKey)
        }
        get { iCloudStore?.bool(forKey: enableSyncKey) ?? false }
    }
    
    public static var enableHapticFeedback: Bool {
        set { set(newValue, forKey: enableHapticFeedbackKey) }
        get { get(enableHapticFeedbackKey, defaultValue: defaultEnableHapticFeedback) }
    }
    
    public static var enableAudioFeedback: Bool {
        set { set(newValue, forKey: enableAudioFeedbackKey) }
        get { get(enableAudioFeedbackKey, defaultValue: defaultEnableAudioFeedback) }
    }
    
    public static var colonCalloutCharacters: String {
        set { set(newValue, forKey: colonCalloutCharactersKey) }
        get { get(colonCalloutCharactersKey, defaultValue: defaultColonCalloutCharacters) }
    }
    
    public static var commaCalloutCharacters: String {
        set { set(newValue, forKey: commaCalloutCharactersKey) }
        get { get(commaCalloutCharactersKey, defaultValue: defaultCommaCalloutCharacters) }
    }
    
    public static func resetToDefaults() {
        enableHapticFeedback = defaultEnableHapticFeedback
        enableAudioFeedback = defaultEnableAudioFeedback
        colonCalloutCharacters = defaultColonCalloutCharacters
        commaCalloutCharacters = defaultCommaCalloutCharacters
    }
    
    private static func set<T>(_ value: T, forKey key: String) {
        if let store = iCloudStore {
            store.set(value, forKey: key)
        } else {
            localStore?.set(value, forKey: key)
        }
    }
    
    private static func get<T>(_ key: String, defaultValue: T) -> T {
        if let store = iCloudStore {
            return store.object(forKey: key) as? T ?? defaultValue
        } else {
            return localStore?.object(forKey: key) as? T ?? defaultValue
        }
    }
    
    private static func syncAllPreferencesToCloud() {
        guard let iCloudStore = iCloudStore else {
            NSLog("Error: iCloud store is not available")
            return
        }
   
        iCloudStore.set(enableHapticFeedback, forKey: enableHapticFeedbackKey)
        iCloudStore.set(enableAudioFeedback, forKey: enableAudioFeedbackKey)
        iCloudStore.set(colonCalloutCharacters, forKey: colonCalloutCharactersKey)
        iCloudStore.set(commaCalloutCharacters, forKey: commaCalloutCharactersKey)
    }
}

