//
//  KeyboardFeedback.swift
//  Armenian
//
//  Created by arshak ‎ on 04.04.23.
//

import Foundation
import KeyboardKit
import SwiftUI

/**
 A modified copy of StandardHapticFeedbackEngine that makes light impact via to use `.soft` as a style
 */
open class MyHapticFeedbackEngine: HapticFeedbackEngine {
    
    public init() {}
    
    private var notificationGenerator = UINotificationFeedbackGenerator()
    private var lightImpactGenerator = UIImpactFeedbackGenerator(style: .soft)
    private var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private var selectionGenerator = UISelectionFeedbackGenerator()
    
    /**
     Prepare a certain haptic feedback type.
     */
    open func prepare(_ feedback: HapticFeedback) {
        switch feedback {
        case .error, .success, .warning: notificationGenerator.prepare()
        case .lightImpact: lightImpactGenerator.prepare()
        case .mediumImpact: mediumImpactGenerator.prepare()
        case .heavyImpact: heavyImpactGenerator.prepare()
        case .selectionChanged: selectionGenerator.prepare()
        case .none: return
        }
    }

    /**
     Trigger a certain haptic feedback type.
     */
    open func trigger(_ feedback: HapticFeedback) {
        switch feedback {
        case .lightImpact: lightImpactGenerator.impactOccurred()
        case .mediumImpact: mediumImpactGenerator.impactOccurred()
        case .heavyImpact: heavyImpactGenerator.impactOccurred()
        case .selectionChanged: selectionGenerator.selectionChanged()
        case .none: return
        default: return
        }
    }
}
