//
//  ArmenianKeyboardLayoutProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import Foundation
import KeyboardKit
import SharedDefaults

class ArmenianKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    deinit {
        NSLog("---- ArmenianKeyboardLayoutProvider")
    }
    
    init(keyboardContext: KeyboardContext, inputSetProvider: InputSetProvider, layout: Layout) {
        self.layout = layout
        
        super.init(keyboardContext: keyboardContext, inputSetProvider: inputSetProvider)
    }
    let layout: Layout
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let keyboardLayout: KeyboardLayout
        
        switch context.keyboardType {
        case .alphabetic(_):
            keyboardLayout = createAlphabeticLayout(context: context)
        case .numeric:
            keyboardLayout = createNumericLayout(context: context)
        case .symbolic:
            keyboardLayout = createSymbolicLayout(context: context)
        default:
            keyboardLayout = super.keyboardLayout(for: context)
        }
        
        let rowWidthOverrides = layout.rowWidthPercentageOverrides(for: context.keyboardType)
        if !rowWidthOverrides.isEmpty {
            for (index, value) in rowWidthOverrides {
                keyboardLayout.itemRows[index] = keyboardLayout.itemRows[index].map { (item: KeyboardLayoutItem ) -> KeyboardLayoutItem in
                    var modifiedItem = item
                    modifiedItem.size.width = .percentage(value)
                    return modifiedItem
                }
            }
        }
        
        return keyboardLayout
    }
    
    private func createAlphabeticLayout(context: KeyboardContext) -> KeyboardLayout {
        let keyboardLayout = super.keyboardLayout(for: context)
        let isUpperCased = context.isUpperCased
        
        keyboardLayout.itemRows.insert(
            createShiftKey(context, keyboardLayout),
            before: .character(isUpperCased ? "Զ" : "զ"),
            atRow: 3
        )
        keyboardLayout.itemRows.insert(
            createBackspaceKey(keyboardLayout),
            after: layout.characterBeforeBackspace(isUpperCased),
            atRow: 3
        )
        
        keyboardLayout.itemRows.append(createBottomRow(context, keyboardLayout))
        
        return keyboardLayout
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
            action: action,
            width: .percentage(0.1)
        )
        
        // The third row is special and behaves differently,
        // hence I need to manually adjust the width of each item.
        layout.itemRows[2] = layout.itemRows[2].map { (item: KeyboardLayoutItem ) -> KeyboardLayoutItem in
            var modifiedItem = item
            modifiedItem.size.width = .percentage(0.1)
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
        let bottomSystemKeyWidth = bottomSystemButtonWidth(for: context)
        
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
            action: .keyboardType(newKeyboardType),
            width: bottomSystemKeyWidth
        )
        let spacebarKey = createLayoutItem(
            layout: layout,
            action: .space,
            width: .available
        )
        let primaryAction = KeyboardAction.primary(
            context.textDocumentProxy.returnKeyType?.keyboardReturnKeyType ?? .return
        )
        let primaryKey = createLayoutItem(
            layout: layout,
            action: primaryAction,
            width: .percentage(0.2)
        )
        
        let commaCalloutKey = createLayoutItem(
            layout: layout,
            action: .character(","),
            width: .percentage(0.1)
        )
        let colonCalloutKey = createLayoutItem(
            layout: layout,
            action: .character("։"),
            width: .percentage(0.1)
        )
        
        let shouldDisplayGlobe = context.needsInputModeSwitchKey
        lazy var globeItem = createLayoutItem(
            layout: layout,
            action: .nextKeyboard,
            width: bottomSystemKeyWidth
        )
        return [
            keyboardTypeKey,
            !shouldDisplayGlobe ? nil : globeItem,
            commaCalloutKey,
            spacebarKey,
            colonCalloutKey,
            primaryKey
        ].compactMap { $0 }
    }
    
    
    /**
     The width of bottom system buttons.
     */
    private func bottomSystemButtonWidth(for context: KeyboardContext) -> KeyboardLayoutItemWidth {
        if context.deviceType == .phone {
            let isPortrait = context.interfaceOrientation.isPortrait
            return .percentage(isPortrait ? 0.123 : 0.095)
        } else {
            return .input
        }
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
