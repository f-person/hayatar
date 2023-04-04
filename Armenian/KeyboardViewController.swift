//
//  KeyboardViewController.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import UIKit
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {
    private var sharedStore: UserDefaults? {
        UserDefaults(suiteName: "group.dev.fperson.hayatar.shared")
    }
    
    private func getBool(forKey key: String, default defaultValue: Bool) -> Bool {
        sharedStore?.object(forKey: key) as? Bool ?? defaultValue
    }
    
    override func viewDidLoad() {
        String.sentenceDelimiters = ["։"]
        
        keyboardContext.setLocale(.armenian)
        
        do {
            calloutActionProvider = try ArmenianCalloutActionProvider()
        } catch {
            NSLog("Could not initialize ArmenianCalloutActionProvider: \(error)")
        }
        inputSetProvider = ArmenianInputSetProvider()
        let shouldEnableHapticFeedback = getBool(forKey: "enableHapticFeedback", default: true)
        let shouldEnableAudioFeedback = getBool(forKey: "enableAudioFeedback", default: true)
        
        keyboardLayoutProvider = ArmenianKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider
        )
        
        keyboardFeedbackSettings = KeyboardFeedbackSettings(
            audioConfiguration: shouldEnableAudioFeedback ? .enabled : .noFeedback,
            hapticConfiguration: shouldEnableHapticFeedback ? .enabled : .noFeedback
        )
        keyboardFeedbackHandler = StandardKeyboardFeedbackHandler(settings: keyboardFeedbackSettings)
        
        keyboardActionHandler = ArmenianActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}

