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
    init(defaults: SharedDefaults) {
        self.defaults = defaults
    }
    private let defaults: SharedDefaults
    
    private let spellChecker: SpellCheckerWrapper = SpellCheckerWrapper()
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        guard !text.isEmpty else {
            completion(.success([]))
            return
        }
        NSLog("Gettings suggestions for \(text)")
        
        let normalizedText = text.lowercased().replacingOccurrences(of: "եւ", with: "և")
        let suggestions = spellChecker.getSuggestions(for: normalizedText)
        NSLog("Got suggestions: \(suggestions)")
        let replaceYev = defaults.replaceYev.value
        var autocompleteSuggestions = suggestions.prefix(3).map {
            var suggestionText: String
            if replaceYev {
                suggestionText = $0.replacingOccurrences(of: "և", with: "եւ")
            } else {
                suggestionText = $0
            }
            
            return AutocompleteSuggestion(text: suggestionText)
        }
        
        if autocompleteSuggestions.count < 3 {
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


class SpellCheckerWrapper {
    private let spellChecker: SpellChecker
    private var isLoaded = false
    
    init() {
        spellChecker = SpellChecker()
        // TODO(f-person): Add support for other dictionaries
        updateLanguage("hy_AM")
        isLoaded = true
    }
    
    public func getSuggestions(for word: String) -> [String] {
        if !isLoaded {
            return []
        }
        
        let suggestions = spellChecker.getSuggestionsForWord(word)
        NSLog("[SpellCheckerWrapper] suggestions: \(suggestions ?? [])")
        return suggestions as? [String] ?? []
    }
    
    private func updateLanguage(_ language: String) {
        spellChecker.updateLanguage(language)
    }
}
