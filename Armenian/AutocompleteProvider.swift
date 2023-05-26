//
//  AutocompleteProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 11.04.23.
//

import Foundation
import KeyboardKit
import SharedDefaults

class HunspellAutocompleteProvider: AutocompleteProvider {
    deinit {
        NSLog("---- HunspellAutocompleteProvider")
    }
    
    init(defaults: SharedDefaults) {
        self.defaults = defaults
        if let dictionary = SpellCheckDictionary(rawValue: defaults.spellCheckDictionary.value) {
            spellChecker.updateLanguage(dictionary.filename)
        } else {
            spellChecker.updateLanguage(PreferenceKey.spellCheckDictionary.defaultValue as! String)
        }
    }
    private let defaults: SharedDefaults
    
    private let spellChecker: SpellCheckerWrapper = SpellCheckerWrapper()
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        guard !text.isEmpty else {
            completion(.success([]))
            return
        }
        
        let normalizedText = text.lowercased().replacingOccurrences(of: "եւ", with: "և")
        let suggestions = spellChecker.getSuggestions(for: normalizedText)
        let replaceYev = defaults.replaceYev.value
        var autocompleteSuggestions = suggestions.map {
            var suggestionText: String
            if replaceYev {
                suggestionText = $0.replacingOccurrences(of: "և", with: "եւ")
            } else {
                suggestionText = $0
            }
            
            if text.first!.isUppercase {
                suggestionText = suggestionText.capitalizingFirstLetter()
            }
            
            return AutocompleteSuggestion(text: suggestionText)
        }
        
        if !autocompleteSuggestions.contains(where: { suggestion -> Bool in suggestion.text == text }) {
            autocompleteSuggestions.insert(
                AutocompleteSuggestion(text: text, title: "«\(text)»"),
                at: 0
            )
        }
        
        completion(.success(autocompleteSuggestions))
    }
    
    var locale: Locale = .current
    let canIgnoreWords: Bool = false
    let canLearnWords: Bool = false
    let ignoredWords: [String] = []
    let learnedWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}

class SpellCheckerWrapper {
    private let spellChecker: SpellChecker = SpellChecker()
    private var isLoaded = false
    
    public func updateLanguage(_ language: String) {
        isLoaded = false
        spellChecker.updateLanguage(language)
        isLoaded = true
    }
    
    public func getSuggestions(for word: String) -> [String] {
        if !isLoaded {
            return []
        }
        
        let suggestions = spellChecker.getSuggestionsForWord(word)
        return suggestions as? [String] ?? []
    }
}
