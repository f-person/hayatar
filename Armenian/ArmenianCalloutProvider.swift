//
//  ArmenianCalloutProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 28.03.23.
//

import Foundation
import KeyboardKit
import SharedDefaults

class ArmenianCalloutActionProvider: BaseCalloutActionProvider {
    public init(defaults: SharedDefaults) throws {
        self.defaults = defaults
    }
    private let defaults: SharedDefaults
    
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
            case "։":
                return defaults.colonCalloutCharacters.map { .character(String($0)) }
            case ",":
                return defaults.commaCalloutCharacters.map { .character(String($0)) }
            default:
                return super.calloutActions(for: action)
            }
        default:
            return super.calloutActions(for: action)
        }
    }
}
