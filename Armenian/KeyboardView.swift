//
//  KeyboardView.swift
//  Armenian
//
//  Created by arshak ‎ on 23.04.23.
//

import Foundation
import SwiftUI
import KeyboardKit

struct KeyboardView: View {
    let controller: KeyboardInputViewController
    let shouldDisplayCalloutHints: Bool
    
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext
    
    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    
    var body: some View {
        let hintFont = self.hintFont
        let hintPadding = self.hintPadding
        
        return VStack (spacing: 0) {
            autocompleteToolbar
            
            SystemKeyboard(
                controller: controller,
                autocompleteToolbarMode: .none,
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
                                .font(hintFont)
                                .foregroundColor(Color.secondary)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(hintPadding)
                        }
                    } else {
                        content
                    }
                }
            )
        }
    }
    
    private var hintFont: Font {
        if keyboardContext.deviceType == .pad {
            return .system(size: 14)
        } else {
            return .system(size: 10)
        }
    }
    
    private var hintPadding: EdgeInsets {
        if keyboardContext.deviceType == .pad {
            return .init(top: 3, leading: 0, bottom: 0, trailing: 5)
        } else {
            return .init(top: 1, leading: 0, bottom: 0, trailing: 2)
        }
    }
    
    
    private var autocompleteToolbar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            AutocompleteToolbar(
                suggestions: autocompleteContext.suggestions,
                locale: keyboardContext.locale,
                suggestionAction: controller.insertAutocompleteSuggestion
            )
        }
        .opacity(keyboardContext.prefersAutocomplete ? 1 : 0) // Still allocate height to make room for callouts
    }
}
