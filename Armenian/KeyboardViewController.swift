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
    
    override func viewDidLoad() {
        String.sentenceDelimiters = ["։"]
        
        keyboardContext.setLocale(.armenian)
        autocompleteProvider = HunspellAutocompleteProvider()
        
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
    
    override func viewWillSetupKeyboard() {
        setup {
            customSystemKeyboard(
                controller: $0,
                shouldDisplayCalloutHints: self.defaults.displayCalloutHints.value
            )
        }
    }
}

func customSystemKeyboard(
    controller: KeyboardInputViewController,
    shouldDisplayCalloutHints: Bool
) -> some View {
    return SystemKeyboard(
        controller: controller,
        buttonContent: { item in
            let content = SystemKeyboardButtonContent(
                action: item.action,
                appearance: controller.keyboardAppearance,
                keyboardContext: controller.keyboardContext
            )
            
            if !shouldDisplayCalloutHints {
                content
            } else if case .character(let char) = item.action,
                      let singleCallout = ArmenianCalloutActionProvider.singleCharacterCallouts[char.lowercased()] {
                
                ZStack {
                    content
                    Text(singleCallout)
                        .font(.caption2)
                        .foregroundColor(Color.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing, 1)
                        .padding(.top, -1)
                }
            } else {
                content
            }
        }
    )
}

