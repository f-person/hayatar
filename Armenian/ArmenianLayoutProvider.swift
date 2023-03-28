//
//  ArmenianKeyboardLayoutProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import Foundation
import KeyboardKit

/**
 This demo-specific appearance inherits the standard one and
 replaces its input rows with completely custom actions.
 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom layout provider.
 The layout basically just makes a single key wider than the
 rest of the keys.
 */
class ArmenianKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        
        if case .numeric = keyboardContext.keyboardType {
            return layout
        }
        
        let isUpperCased = keyboardContext.keyboardType.isAlphabeticUppercased
        
        let shiftKey = createLayoutItem(
            layout: layout,
            action: .shift(currentCasing: isUpperCased ? .uppercased : .lowercased)
        )
        let backspaceKey = createLayoutItem(layout: layout, action: .backspace)
        
        let newKeyboardType: KeyboardType
        switch keyboardContext.keyboardType {
        case .alphabetic:
            newKeyboardType = .numeric
            break;
        default:
            newKeyboardType = .alphabetic(.auto)
            break;
        }
        
        
        let keyboardTypeKey = createLayoutItem(
            layout: layout,
            action: .keyboardType(newKeyboardType)
        )
        let spacebarKey = createLayoutItem(
            layout: layout,
            action: .space,
            width: .available
        )
        let primaryKey = createLayoutItem(
            layout: layout,
            action: .primary(keyboardContext.textDocumentProxy.returnKeyType?.keyboardActionReturnType ?? .return),
            width: .inputPercentage(2)
        )
        
        layout.itemRows.insert(shiftKey, before: .character(isUpperCased ? "Զ" : "զ"), atRow: 3)
        layout.itemRows.insert(backspaceKey, after: .character(isUpperCased ? "Շ" : "շ"), atRow: 3)
        layout.itemRows.append([keyboardTypeKey, spacebarKey, primaryKey])
        
        return layout
    }
    
    private func createLayoutItem(
        layout: KeyboardLayout,
        action: KeyboardAction,
        width: KeyboardLayoutItemWidth = .inputPercentage(1)
    ) -> KeyboardLayoutItem {
        return KeyboardLayoutItem(
            action: action,
            size: KeyboardLayoutItemSize(width: width, height: layout.idealItemHeight),
            insets: layout.idealItemInsets
        )
    }
}
