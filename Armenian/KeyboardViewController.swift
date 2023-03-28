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
        keyboardContext.setLocale(.armenian)
        
        do {
            calloutActionProvider = try ArmenianCalloutActionProvider()
        } catch {
            print("Could not initialize ArmenianCalloutActionProvider: \(error)")
        }
        inputSetProvider = ArmenianInputSetProvider()
        
        keyboardLayoutProvider = ArmenianKeyboardLayoutProvider(
            keyboardContext: keyboardContext,
            inputSetProvider: inputSetProvider
        )
        super.viewDidLoad()
    }
    
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        print("[viewWillSetupKeyboard]")
    }
}
