//
//  ArmenianActionHandler.swift
//  Armenian
//
//  Created by arshak ‎ on 03.04.23.
//

import Foundation
import KeyboardKit
import UIKit

class ArmenianActionHandler: StandardKeyboardActionHandler {
    override func tryEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldEndSentence(after: gesture, on: action) else { return }
        textDocumentProxy.endArmenianSentence()
    }
}

private extension UITextDocumentProxy {
    func endArmenianSentence() {
        guard isCursorAtTheEndOfTheCurrentWord else { return }
        while (documentContextBeforeInput ?? "").hasSuffix(" ") {
            deleteBackward(times: 1)
        }
        insertText("։ ")
    }
}
