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
            let singleCallout = ArmenianCalloutActionProvider.singleCharacterCallouts[char.lowercased()]
            if singleCallout != nil {
                return [.character(singleCallout!)]
            }
            
            switch char {
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
                return defaults.colonCalloutCharacters.value.map { .character(String($0)) }
            case ",":
                return defaults.commaCalloutCharacters.value.map { .character(String($0)) }
            default:
                return super.calloutActions(for: action)
            }
        default:
            return super.calloutActions(for: action)
        }
    }
}

extension ArmenianCalloutActionProvider {
    /**
     A dictionary of characters that have a single callout option.
     Each key represents a character (usually, in the Armenian alphabet),
     and its corresponding value represents its callout character.
     */
    static let singleCharacterCallouts: [String: String] = [
        "ե": "և",
        "է": "1", "թ": "2", "փ": "3", "ձ": "4", "ջ": "5",
        "ր": "6", "չ": "7", "ճ": "8", "ժ": "9", "ծ": "0"
    ]
}
