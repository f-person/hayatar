//
//  KeyboardViewController.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import UIKit
import SwiftUI
import KeyboardKit
import SharedDefaults

class KeyboardViewController: KeyboardInputViewController {
    private let defaults = SharedDefaults(canAccessCloud: false)
    
    deinit {
        NSLog("---- KeyboardViewController")
    }
    
    override func viewDidLoad() {
        String.sentenceDelimiters = ["։"]
        
        let layout = Layout(rawValue: defaults.layout.value)!
        
        keyboardContext.setLocale(.armenian)
        if defaults.enableSuggestions.value {
            autocompleteProvider = HunspellAutocompleteProvider(defaults: defaults)
        }
        
        do {
            calloutActionProvider = try ArmenianCalloutActionProvider(defaults: defaults)
        } catch {
            NSLog("Could not initialize ArmenianCalloutActionProvider: \(error)")
        }
        inputSetProvider = ArmenianInputSetProvider(layout: layout)
        
        keyboardLayoutProvider = ArmenianKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider,
            layout: layout
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
        
        keyboardAppearance = ArmenianKeyboardAppearance(keyboardContext: keyboardContext)
        
        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        let shouldDisplayCalloutHints = defaults.displayCalloutHints.value
        let layout = Layout(rawValue: defaults.layout.value)!
        
        setup {controller in
            KeyboardView(
                shouldDisplayCalloutHints: shouldDisplayCalloutHints,
                keyboardAppearance: controller.keyboardAppearance,
                keyboardActionHandler: controller.keyboardActionHandler,
                keyboardLayoutProvider: controller.keyboardLayoutProvider,
                calloutContext: controller.calloutContext,
                insertAutocompleteSuggestion: { [weak controller] suggestion in
                    controller?.insertAutocompleteSuggestion(suggestion)
                },
                width: controller.view.frame.width,
                layout: layout
            )
        }
    }
}
