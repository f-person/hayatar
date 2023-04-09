//
//  SharedDefaults.swift
//  SharedDefaults
//
//  Created by arshak ‎ on 07.04.23.
//

import Foundation

public class SharedDefaults {
    public init(canReadCloud: Bool) {
        self.canReadCloud = canReadCloud
    }
    private let canReadCloud: Bool
    
    public static let appGroupID = "group.dev.fperson.hayatar.shareddefaults"
    
    public var localStore: UserDefaults? {
        UserDefaults(suiteName: SharedDefaults.appGroupID)
    }
    
    private var cloudStore: NSUbiquitousKeyValueStore? {
        if FileManager.default.ubiquityIdentityToken != nil {
            return NSUbiquitousKeyValueStore.default
        } else {
            return nil
        }
    }
    
    public struct Keys {
        public static let enableHapticFeedback = "enableHapticFeedback"
        public static let enableAudioFeedback = "enableAudioFeedback"
        public static let commaCalloutCharacters = "commaCalloutCharacters"
        public static let colonCalloutCharacters = "colonCalloutCharacters"
        public static let enableSync = "enableSync"
    }
    
    public static let defaultEnableHapticFeedback = true
    public static let defaultEnableAudioFeedback = true
    public static let defaultColonCalloutCharacters = "։,՞֊՛՝՜"
    public static let defaultCommaCalloutCharacters = ",«»—՟()՚"
    
    public var enableSync: Bool {
        set {
            cloudStore?.set(newValue, forKey: Keys.enableSync)
            if newValue {
                syncPreferencesToCloud()
            } else {
                syncPreferencesToLocal()
                stopSyncingWithCloud()
            }
        }
        get {
            return cloudStore?.bool(forKey: Keys.enableSync) ?? false
        }
    }
    
    public var enableHapticFeedback: Bool {
        set { set(newValue, forKey: Keys.enableHapticFeedback) }
        get { get(Keys.enableHapticFeedback, defaultValue: SharedDefaults.defaultEnableHapticFeedback) }
    }
    
    public var enableAudioFeedback: Bool {
        set { set(newValue, forKey: Keys.enableAudioFeedback) }
        get { get(Keys.enableAudioFeedback, defaultValue: SharedDefaults.defaultEnableAudioFeedback) }
    }
    
    public var colonCalloutCharacters: String {
        set { set(newValue, forKey: Keys.colonCalloutCharacters) }
        get { get(Keys.colonCalloutCharacters, defaultValue: SharedDefaults.defaultColonCalloutCharacters) }
    }
    
    public var commaCalloutCharacters: String {
        set { set(newValue, forKey: Keys.commaCalloutCharacters) }
        get { get(Keys.commaCalloutCharacters, defaultValue: SharedDefaults.defaultCommaCalloutCharacters) }
    }
    
    public func resetToDefaults() {
        enableHapticFeedback = SharedDefaults.defaultEnableHapticFeedback
        enableAudioFeedback = SharedDefaults.defaultEnableAudioFeedback
        colonCalloutCharacters = SharedDefaults.defaultColonCalloutCharacters
        commaCalloutCharacters = SharedDefaults.defaultCommaCalloutCharacters
    }
    
    private func set<T>(_ value: T, forKey key: String) {
        localStore?.set(value, forKey: key)
        if enableSync {
            cloudStore?.set(value, forKey: key)
        }
    }
    
    private func get<T>(_ key: String, defaultValue: T) -> T {
        if canReadCloud && enableSync {
            return cloudStore?.object(forKey: key) as? T ?? defaultValue
        } else if let localValue = localStore?.object(forKey: key) as? T {
            return localValue
        } else {
            return defaultValue
        }
    }
    
    private func getLocal<T>(_ key: String, defaultValue: T) -> T {
        return localStore?.object(forKey: key) as? T ?? defaultValue
    }
    
    public func syncPreferencesToCloud() {
        guard let iCloudStore = cloudStore else {
            NSLog("Error: iCloud store is not available")
            return
        }
        let enableHapticFeedback = getLocal(Keys.enableHapticFeedback, defaultValue: SharedDefaults.defaultEnableHapticFeedback)
        let enableAudioFeedback = getLocal(Keys.enableAudioFeedback, defaultValue: SharedDefaults.defaultEnableAudioFeedback)
        let colonCalloutCharacters = getLocal(Keys.colonCalloutCharacters, defaultValue: SharedDefaults.defaultColonCalloutCharacters)
        let commaCalloutCharacters = getLocal(Keys.commaCalloutCharacters, defaultValue: SharedDefaults.defaultCommaCalloutCharacters)
        
        iCloudStore.set(enableHapticFeedback, forKey: Keys.enableHapticFeedback)
        iCloudStore.set(enableAudioFeedback, forKey: Keys.enableAudioFeedback)
        iCloudStore.set(colonCalloutCharacters, forKey: Keys.colonCalloutCharacters)
        iCloudStore.set(commaCalloutCharacters, forKey: Keys.commaCalloutCharacters)
    }
    
    public func stopSyncingWithCloud() {
        cloudStore?.removeObject(forKey: Keys.enableHapticFeedback)
        cloudStore?.removeObject(forKey: Keys.enableAudioFeedback)
        cloudStore?.removeObject(forKey: Keys.colonCalloutCharacters)
        cloudStore?.removeObject(forKey: Keys.commaCalloutCharacters)
    }
    
    /**
     Fetches cloud preferences if sync is enabled.
     */
    public func maybeFetchCloudPreferences() {
        if enableSync {
            syncPreferencesToLocal()
        }
    }
    
    public func syncPreferencesToLocal() {
        guard let iCloudStore = cloudStore else {
            NSLog("Error: iCloud store is not available")
            return
        }
        
        let hapticFeedback = iCloudStore.object(forKey: Keys.enableHapticFeedback) as? Bool ?? SharedDefaults.defaultEnableHapticFeedback
        let audioFeedback = iCloudStore.object(forKey: Keys.enableAudioFeedback) as? Bool ?? SharedDefaults.defaultEnableAudioFeedback
        let colonCallouts = iCloudStore.object(forKey: Keys.colonCalloutCharacters) as? String ?? SharedDefaults.defaultColonCalloutCharacters
        let commaCallouts = iCloudStore.object(forKey: Keys.commaCalloutCharacters) as? String ?? SharedDefaults.defaultCommaCalloutCharacters
        
        localStore?.set(hapticFeedback, forKey: Keys.enableHapticFeedback)
        localStore?.set(audioFeedback, forKey: Keys.enableAudioFeedback)
        localStore?.set(colonCallouts, forKey: Keys.colonCalloutCharacters)
        localStore?.set(commaCallouts, forKey: Keys.commaCalloutCharacters)
    }
}
