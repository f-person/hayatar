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
    case displayCalloutHints
    case replaceYev
    case spellCheckDictionary
    case layout
    case enableSuggestions
    case commaReplacement
    
    public var defaultValue: Any {
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
        case .displayCalloutHints:
            return true
        case .replaceYev:
            return false
        case .spellCheckDictionary:
            return SpellCheckDictionary.armenianSpellCheckDictionary.rawValue
        case .layout:
            return Layout.phonetic.rawValue
        case .enableSuggestions:
            return true
        case .commaReplacement:
            return ","
        }
    }
}

public enum SpellCheckDictionary: String, CaseIterable {
    case armenianSpellCheckDictionary
    case martakertHyspell
    
    public var filename: String {
        switch self {
        case .armenianSpellCheckDictionary:
            return "arm_spellcheck_dict"
        case .martakertHyspell:
            return "martakert_hyspell"
        }
    }
    
    public var name: String {
        switch self {
        case .armenianSpellCheckDictionary:
            return "Armenian Spell Checker Dictionary"
        case .martakertHyspell:
            return "Hyspell by martakert"
        }
    }
    
    public var totalWords: Int {
        switch self {
        case .armenianSpellCheckDictionary:
            return 47306
        case .martakertHyspell:
            return 65344
        }
    }
}

/**
 This exists to fix naming conflicts with SwiftUI
 */
public typealias SLayout = Layout

public enum Layout: String, CaseIterable {
    case phonetic
    case western
    
    public var name: String {
        switch self {
        case .phonetic:
            return "Phonetic"
        case .western:
            return "Western"
        }
    }
}
