//
//  ArmenianCalloutProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 28.03.23.
//

import Foundation
import KeyboardKit

class ArmenianCalloutActionProvider: BaseCalloutActionProvider {
    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .character(let char):
            switch char {
            case "ե":
                return [.character("ե"), .character("և")]
            case "Ե":
                return [.character("Ե"), .character("և")]
            case "ւ":
                return [
                    .character("ւ"),
                    .character("ու"),
                    .character("եւ"),
                    .character("աւ"),
                    .character("իւ"),
                    .character("ըւ")
                ]
            case "Ւ":
                return [
                    .character("Ւ"),
                    .character("Ու"),
                    .character("Եւ"),
                    .character("Աւ"),
                    .character("Իւ"),
                    .character("Ըւ")
                ]
            case ",":
                return [
                    .character(","),
                    .character("՞"),
                    .character("֊"),
                    .character("՛"),
                    .character("՝"),
                    .character("՜")
                ]
            case "։":
                return [
                    .character("։"),
                    .character("՟"),
                    .character("»"),
                    .character("«")
                ]
            default:
                return super.calloutActions(for: action)
            }
        default:
            return super.calloutActions(for: action)
        }
    }
}
