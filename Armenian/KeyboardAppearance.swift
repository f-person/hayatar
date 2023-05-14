//
//  KeyboardAppearance.swift
//  Armenian
//
//  Created by arshak ‎ on 14.05.23.
//

import Foundation
import KeyboardKit

/**
 A slightly modified version of `StandardKeyboardAppearance` that makes the button font
 more consistent between lowercase and uppercase states.
 */
class ArmenianKeyboardAppearance: StandardKeyboardAppearance {
    override func buttonFontSize(for action: KeyboardAction) -> CGFloat {
        if let override = buttonFontSizePadOverride(for: action) { return override }
        if buttonImage(for: action) != nil { return 20 }
        if let override = buttonFontSizeActionOverride(for: action) { return override }
        if action.isSystemAction || action.isPrimaryAction { return 16 }
        
        return 23
    }
    
    override func buttonFontWeight(for action: KeyboardAction) -> KeyboardFontWeight? {
        switch action {
        case .backspace: return .regular
        case .character(let char): return char.isLowercased ? .light : .regular
        default: return buttonImage(for: action) != nil ? .light : nil
        }
    }
    
    /**
     The button font size to force override for some actions.
     */
    func buttonFontSizeActionOverride(for action: KeyboardAction) -> CGFloat? {
        switch action {
        case .keyboardType(let type): return buttonFontSize(for: type)
        case .space: return 16
        default: return nil
        }
    }
    
    /**
     The button font size to force override for iPad devices.
     */
    func buttonFontSizePadOverride(for action: KeyboardAction) -> CGFloat? {
        guard keyboardContext.deviceType == .pad else { return nil }
        let isLandscape = keyboardContext.interfaceOrientation.isLandscape
        guard isLandscape else { return nil }
        if action.isAlphabeticKeyboardTypeAction { return 22 }
        if action.isKeyboardTypeAction(.numeric) { return 22 }
        if action.isKeyboardTypeAction(.symbolic) { return 20 }
        return nil
    }
}
