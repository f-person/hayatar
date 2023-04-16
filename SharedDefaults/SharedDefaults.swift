//
//  SharedDefaults.swift
//  SharedDefaults
//
//  Created by arshak ‎ on 07.04.23.
//

import Foundation

public class SharedDefaults {
    public init(canAccessCloud: Bool) {
        self.canAccessCloud = canAccessCloud
    }
    private let canAccessCloud: Bool
    
    public static let appGroupID = "group.dev.fperson.hayatar.shareddefaults"
    
    public var localStore: UserDefaults? {
        UserDefaults(suiteName: SharedDefaults.appGroupID)
    }
    
    private var cloudStore: NSUbiquitousKeyValueStore? {
        if canAccessCloud && FileManager.default.ubiquityIdentityToken != nil {
            return NSUbiquitousKeyValueStore.default
        } else {
            return nil
        }
    }
    
    private var shouldUseCloud: Bool {
        let enableSyncKey = PreferenceKey.enableSync
        
        return canAccessCloud && cloudStore?.bool(forKey: enableSyncKey.rawValue) ?? enableSyncKey.defaultValue as! Bool
    }
    
    private lazy var storages = Storage(local: localStore!, cloud: cloudStore, shouldUseCloud: shouldUseCloud)
    
    public lazy var enableHapticFeedback = Preference<Bool>(storage: storages, key: .enableHapticFeedback)
    public lazy var enableAudioFeedback = Preference<Bool>(storage: storages, key: .enableAudioFeedback)
    public lazy var colonCalloutCharacters = Preference<String>(storage: storages, key: .colonCalloutCharacters)
    public lazy var commaCalloutCharacters = Preference<String>(storage: storages, key: .commaCalloutCharacters)
    public lazy var enableAutocapitalization = Preference<Bool>(storage: storages, key: .enableAutocapitalization)
    
    public lazy var enableSync: Preference<Bool> = {
        var storage = storages
        storage.shouldUseCloud = true
        return Preference<Bool>(storage: storage, key: .enableSync)
    }()
    
    public func resetToDefaults() {
        enableHapticFeedback.value = enableHapticFeedback.key.defaultValue as! Bool
        enableAudioFeedback.value = enableAudioFeedback.key.defaultValue as! Bool
        colonCalloutCharacters.value = colonCalloutCharacters.key.defaultValue as! String
        commaCalloutCharacters.value = commaCalloutCharacters.key.defaultValue as! String
        enableAutocapitalization.value = enableAutocapitalization.key.defaultValue as! Bool
    }
    
    public func syncPreferencesToCloud() {
        guard let iCloudStore = cloudStore else {
            NSLog("Error: iCloud store is not available")
            return
        }
        
        for key in PreferenceKey.allCases {
            let localValue = getLocal(key.rawValue, defaultValue: key.defaultValue)
            iCloudStore.set(localValue, forKey: key.rawValue)
        }
    }
    
    public func stopSyncingWithCloud() {
        for key in PreferenceKey.allCases {
            cloudStore?.removeObject(forKey: key.rawValue)
        }
    }
    
    public func syncPreferencesToLocal() {
        guard let iCloudStore = cloudStore else {
            NSLog("Error: iCloud store is not available")
            return
        }
        
        for key in PreferenceKey.allCases {
            let cloudValue = iCloudStore.object(forKey: key.rawValue) ?? key.defaultValue
            localStore?.set(cloudValue, forKey: key.rawValue)
        }
    }
    
    private func getLocal<T>(_ key: String, defaultValue: T) -> T {
        return localStore?.object(forKey: key) as? T ?? defaultValue
    }
    
    /**
     Fetches cloud preferences if sync is enabled.
     */
    public func maybeFetchCloudPreferences() {
        if enableSync.value {
            syncPreferencesToLocal()
        }
    }
}
