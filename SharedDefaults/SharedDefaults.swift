//
//  SharedDefaults.swift
//  SharedDefaults
//
//  Created by arshak ‎ on 07.04.23.
//

import Foundation

public struct SharedDefaults {
    public static let appGroupID = "group.dev.fperson.hayatar.shared"
    
    public static func userDefaultsForAppGroup() -> UserDefaults? {
        return UserDefaults(suiteName: appGroupID)
    }
    
    public static let enableHapticFeedbackKey = "enableHapticFeedback"
    public static let enableAudioFeedbackKey = "enableAudioFeedback"
    public static let colonCalloutCharactersKey = "colonCallouts"
    public static let commaCalloutCharactersKey = "commaCallouts"

    public static let defaultEnableHapticFeedback = true
    public static let defaultEnableAudioFeedback = true
    public static let defaultColonCalloutCharacters = "։,՞֊՛՝՜"
    public static let defaultCommaCalloutCharacters = ",«»—՟()՚"
    
    public static var enableHapticFeedback: Bool {
       set { userDefaultsForAppGroup()?.set(newValue, forKey: enableHapticFeedbackKey) }
       get { userDefaultsForAppGroup()?.object(forKey: enableHapticFeedbackKey) as? Bool ?? defaultEnableHapticFeedback }
    }
    
    public static var enableAudioFeedback: Bool {
       set { userDefaultsForAppGroup()?.set(newValue, forKey: enableAudioFeedbackKey) }
       get { userDefaultsForAppGroup()?.object(forKey: enableAudioFeedbackKey) as? Bool ?? defaultEnableAudioFeedback }
    }

    public static var colonCalloutCharacters: String {
       set { userDefaultsForAppGroup()?.set(newValue, forKey: colonCalloutCharactersKey) }
       get { userDefaultsForAppGroup()?.string(forKey: colonCalloutCharactersKey) ?? defaultColonCalloutCharacters }
    }
    
    public static var commaCalloutCharacters: String {
       set { userDefaultsForAppGroup()?.set(newValue, forKey: commaCalloutCharactersKey) }
       get { userDefaultsForAppGroup()?.string(forKey: commaCalloutCharactersKey) ?? defaultCommaCalloutCharacters }
    }
    
    public static func resetToDefaults() {
        enableHapticFeedback = defaultEnableHapticFeedback
        enableAudioFeedback = defaultEnableAudioFeedback
        colonCalloutCharacters = defaultColonCalloutCharacters
        commaCalloutCharacters = defaultCommaCalloutCharacters
    }
}

