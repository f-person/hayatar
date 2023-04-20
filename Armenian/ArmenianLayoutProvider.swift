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
        switch context.keyboardType {
        case .alphabetic(_):
            return createAlphabeticLayout(context: context)
        case .numeric:
            return createNumericLayout(context: context)
        case .symbolic:
            return createSymbolicLayout(context: context)
        default:
            return super.keyboardLayout(for: context)
        }
    }
    
    private func createAlphabeticLayout(context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        let isUpperCased = context.isUpperCased
        
        layout.itemRows.insert(
            createShiftKey(context, layout),
            before: .character(isUpperCased ? "Զ" : "զ"),
            atRow: 3
        )
        layout.itemRows.insert(
            createBackspaceKey(layout),
            after: .character(isUpperCased ? "Շ" : "շ"),
            atRow: 3
        )
        
        layout.itemRows.append(createBottomRow(context, layout))
        
        return layout
    }
    
    private func createNumericLayout(context: KeyboardContext) -> KeyboardLayout {
        createSecondaryLayout(
            context,
            action: .keyboardType(.symbolic)
        )
    }
    
    private func createSymbolicLayout(context: KeyboardContext) -> KeyboardLayout {
        createSecondaryLayout(
            context,
            action: .keyboardType(.numeric)
        )
    }
    
    private func createSecondaryLayout(
        _ context: KeyboardContext,
        action: KeyboardAction
    ) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        
        let symbolicKey = createLayoutItem(
            layout: layout,
            action: action
        )
        
        // The third row is special and behaves differently,
        // hence I need to manually adjust the width of each item.
        layout.itemRows[2] = layout.itemRows[2].map { (item: KeyboardLayoutItem ) -> KeyboardLayoutItem in
            var modifiedItem = item
            modifiedItem.size.width = .inputPercentage(0.1)
            return modifiedItem
        }
        layout.itemRows.insert(
            symbolicKey,
            before: .character(numericCharAfterKeyboardType),
            atRow: 3
        )
        layout.itemRows.insert(
            createBackspaceKey(layout),
            after: .character(numericCharBeforeBackspace),
            atRow: 3
        )
        
        layout.itemRows.append(createBottomRow(context, layout))
        
        return layout
    }
    
    private func createBottomRow(_ context: KeyboardContext, _ layout: KeyboardLayout) -> KeyboardLayoutItemRow {
        let newKeyboardType: KeyboardType
        switch context.keyboardType {
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
        let primaryAction = KeyboardAction.primary(
            keyboardContext.textDocumentProxy.returnKeyType?.keyboardReturnKeyType ?? .return
        )
        let primaryKey = createLayoutItem(
            layout: layout,
            action: primaryAction,
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
        
        let shouldDisplayGlobe = context.needsInputModeSwitchKey
        return [
            keyboardTypeKey,
            !shouldDisplayGlobe ? nil : createLayoutItem(layout: layout, action: .nextKeyboard),
            commaCalloutKey,
            spacebarKey,
            colonCalloutKey,
            primaryKey
        ].compactMap { $0 }
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
    
    private func createShiftKey(_ context: KeyboardContext, _ layout: KeyboardLayout) -> KeyboardLayoutItem {
        return createLayoutItem(
            layout: layout,
            action: .shift(currentCasing: context.isUpperCased ? .uppercased : .lowercased)
        )
    }
    
    private func createBackspaceKey(_ layout: KeyboardLayout)  -> KeyboardLayoutItem {
        return createLayoutItem(layout: layout, action: .backspace)
    }
}
