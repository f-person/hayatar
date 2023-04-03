//
//  KeyboardViewController.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import UIKit
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {
    override func viewDidLoad() {
        String.sentenceDelimiters = ["։"]
        
        NSLog("[viewDidLoad]")
        keyboardContext.setLocale(.armenian)
        
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
        keyboardActionHandler = ArmenianActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
