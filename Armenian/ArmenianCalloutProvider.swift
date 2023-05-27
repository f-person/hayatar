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
    
    public init(
        rawLayout: String,
        commaReplacement: String,
        colonCalloutCharacters: String,
        commaCalloutCharacters: String
    ) throws {
        self.layout = Layout(rawValue: rawLayout) ?? Layout(rawValue: PreferenceKey.layout.defaultValue as! String)!
        self.commaReplacement = commaReplacement
        self.colonCalloutCharacters = colonCalloutCharacters
        self.commaCalloutCharacters = commaCalloutCharacters
    }
    
    let layout: Layout
    let commaReplacement: String
    let colonCalloutCharacters: String
    let commaCalloutCharacters: String
    
    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .character(let char):
            let singleCallout = layout.singleCharacterCallouts[char.lowercased()]
            
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
                return colonCalloutCharacters.map { .character(String($0)) }
            case commaReplacement:
                return commaCalloutCharacters.map { .character(String($0)) }
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
