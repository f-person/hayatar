//
//  ArmenianKeyboardLayoutProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import Foundation
import KeyboardKit

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
        
        let commaCalloutKey = createLayoutItem(
            layout: layout,
            action: .character(",")
        )
        let colonCalloutKey = createLayoutItem(
            layout: layout,
            action: .character("։")
        )
        
        layout.itemRows.insert(shiftKey, before: .character(isUpperCased ? "Զ" : "զ"), atRow: 3)
        layout.itemRows.insert(backspaceKey, after: .character(isUpperCased ? "Շ" : "շ"), atRow: 3)
        layout.itemRows.append([keyboardTypeKey, colonCalloutKey, spacebarKey, commaCalloutKey, primaryKey])
        
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
