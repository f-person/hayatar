//
//  KeyboardViewController.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import UIKit
import KeyboardKit
import SharedDefaults

class KeyboardViewController: KeyboardInputViewController {
    override func viewDidLoad() {
        String.sentenceDelimiters = ["։"]
        
        keyboardContext.setLocale(.armenian)
        autocompleteProvider = HunspellAutocompleteProvider()
        
        let defaults = SharedDefaults(canAccessCloud: false)
        do {
            calloutActionProvider = try ArmenianCalloutActionProvider(defaults: defaults)
        } catch {
            NSLog("Could not initialize ArmenianCalloutActionProvider: \(error)")
        }
        inputSetProvider = ArmenianInputSetProvider()
        
        keyboardLayoutProvider = ArmenianKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider
        )
        
        keyboardFeedbackSettings = KeyboardFeedbackSettings(
            audioConfiguration: defaults.enableAudioFeedback.value ? .enabled : .noFeedback,
            hapticConfiguration: defaults.enableHapticFeedback.value ? .enabled : .noFeedback
        )
        keyboardFeedbackHandler = StandardKeyboardFeedbackHandler(settings: keyboardFeedbackSettings)
        
        keyboardActionHandler = ArmenianActionHandler(inputViewController: self)
        
        if !defaults.enableAutocapitalization.value {
            keyboardContext.autocapitalizationTypeOverride = KeyboardAutocapitalizationType.none
        }
        
        super.viewDidLoad()
    }
}

