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
    
    init(rawDictionary: String, replaceYev: Bool) {
        if let dictionary = SpellCheckDictionary(rawValue: rawDictionary) {
            spellChecker.updateLanguage(dictionary.filename)
        } else {
            spellChecker.updateLanguage(PreferenceKey.spellCheckDictionary.defaultValue as! String)
        }
        self.replaceYev = replaceYev
    }
    let replaceYev: Bool
    
    let spellChecker: SpellCheckerWrapper = SpellCheckerWrapper()
    
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    func autocompleteSuggestions(for text: String, completion: @escaping AutocompleteCompletion) {
        operationQueue.cancelAllOperations()
        
        let operation = AutocompleteOperation(text: text, provider: self, completion: completion)
        operationQueue.addOperation(operation)
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

class AutocompleteOperation: Operation {
    private let text: String
    private weak var provider: HunspellAutocompleteProvider?
    private let completion: AutocompleteCompletion
    
    init(text: String, provider: HunspellAutocompleteProvider, completion: @escaping AutocompleteCompletion) {
        self.text = text
        self.provider = provider
        self.completion = completion
    }
    
    override func main() {
        guard let provider = provider else {
            return
        }
        
        guard !text.isEmpty else {
            DispatchQueue.main.async {
                self.completion(.success([]))
            }
            return
        }
        
        let normalizedText = text.lowercased().replacingOccurrences(of: "եւ", with: "և")
        let suggestions = provider.spellChecker.getSuggestions(for: normalizedText)
        let replaceYev = provider.replaceYev
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
        
        if !isCancelled {
            DispatchQueue.main.async {
                self.completion(.success(autocompleteSuggestions))
            }
        }
    }
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
