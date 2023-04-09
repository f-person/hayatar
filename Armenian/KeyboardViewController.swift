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
        
        NSLog("audio: \(SharedDefaults.enableAudioFeedback); haptic: \(SharedDefaults.enableHapticFeedback); sync: \(SharedDefaults.enableSync)")
        
        do {
            calloutActionProvider = try ArmenianCalloutActionProvider()
        } catch {
            NSLog("Could not initialize ArmenianCalloutActionProvider: \(error)")
        }
        inputSetProvider = ArmenianInputSetProvider()
        
        keyboardLayoutProvider = ArmenianKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider
        )
        
        keyboardFeedbackSettings = KeyboardFeedbackSettings(
            audioConfiguration: SharedDefaults.enableAudioFeedback ? .enabled : .noFeedback,
            hapticConfiguration: SharedDefaults.enableHapticFeedback ? .enabled : .noFeedback
        )
        keyboardFeedbackHandler = StandardKeyboardFeedbackHandler(settings: keyboardFeedbackSettings)
        
        keyboardActionHandler = ArmenianActionHandler(inputViewController: self)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLocalUserDefaults(_:)),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: nil
        )
        
        super.viewDidLoad()
    }
    
    @objc func updateLocalUserDefaults(_ notification: Notification) {
        SharedDefaults.syncPreferencesToLocal()
    }
}

