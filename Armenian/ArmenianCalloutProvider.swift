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
    deinit {
        NSLog("---- ArmenianCalloutActionProvider")
    }
    
    public init(defaults: SharedDefaults) throws {
        self.defaults = defaults
    }
    // TODO(f-person): Maybe we shouldn't keep an instance of defaults and instead keep only the required properties
    private let defaults: SharedDefaults
    
    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .character(let char):
            let layout = Layout(rawValue: defaults.layout.value)
            let commaCharacter = defaults.commaReplacement.value
            let singleCallout = layout?.singleCharacterCallouts[char.lowercased()]
            
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
            case commaCharacter:
                return defaults.commaCalloutCharacters.value.map { .character(String($0)) }
            case "֎":
                return [.character("֎"), .character("֍")]
            default:
                return super.calloutActions(for: action)
            }
        default:
            return super.calloutActions(for: action)
        }
    }
}
