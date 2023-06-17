//
//  LayoutExtensions.swift
//  Armenian
//
//  Created by arshak ‎ on 17.05.23.
//

import Foundation
import SharedDefaults
import KeyboardKit

public extension Layout {
    var inputSet: AlphabeticInputSet {
        switch self {
        case .phonetic:
            return AlphabeticInputSet(rows: [
                .init(chars: "էթփձջրչճժծ"),
                .init(chars: "քոեռտըւիօպ"),
                .init(chars: "ասդֆգհյկլխ"),
                .init(chars: "զղցվբնմշ"),
            ])
        case .western:
            return AlphabeticInputSet(rows: [
                .init(chars: "«»ձյ-՛՜՞՚օռժ"),
                .init(chars: "խվէրդեըիոբչջ"),
                .init(chars: "աստֆկհճքլթփ"),
                .init(chars: "զցգւպնմշղծ")
            ])
        case .hmQwerty:
            return AlphabeticInputSet(rows: [
                .init(chars: "1234567890"),
                .init(chars: "ճւերտյւիոպ"),
                .init(chars: "ասդֆգհձկլ"),
                .init(chars: "զխծվբնմ")
            ])
        case .typewriter:
            return AlphabeticInputSet(rows: [
                .init(chars: "՝ֆձ֊՞․՛)օէղ"),
                .init(chars: "ճփբսմուկըթծց»"),
                .init(chars: "ջվգեանիտհպր"),
                .init(chars: "ժդչյզլքխշռ")
            ])
        }
        
    }
    
    func characterBeforeBackspace(_ isUppercased: Bool) -> KeyboardAction {
        switch self {
        case .phonetic:
            return .character(isUppercased ? "Շ" : "շ")
        case .western:
            return .character(isUppercased ? "Ծ" : "ծ")
        case .hmQwerty:
            return .character(isUppercased ? "Մ" : "մ")
        case .typewriter:
            return .character(isUppercased ? "Ռ" : "ռ")
        }
    }
    
    func characterAfterShift(_ isUppercased: Bool) -> KeyboardAction {
        switch self {
        case .typewriter:
            return .character(isUppercased ? "Ժ" : "ժ")
        default:
            return .character(isUppercased ? "Զ" : "զ")
        }
    }
    
    /**
     A dictionary of characters that have a single callout option.
     Each key represents a character (usually, in the Armenian alphabet),
     and its corresponding value represents its callout character.
     */
    var singleCharacterCallouts: [String: String] {
        switch self {
        case .phonetic:
            return [
                "ե": "և",
                "է": "1", "թ": "2", "փ": "3", "ձ": "4", "ջ": "5",
                "ր": "6", "չ": "7", "ճ": "8", "ժ": "9", "ծ": "0"
            ]
        case .western:
            return [
                "«": "1", "»": "2", "ձ": "3", "-": "4", "՛": "5",
                "՜": "6", "՞": "7", "՚": "8", "օ": "9", "ռ": "0", "ժ": "և"
            ]
        case .hmQwerty:
            return ["ե": "և"]
        case .typewriter:
            return [
                "՝": "1", "ֆ": "2", "ձ": "3", "֊": "4", "՞": "5",
                "․": "6", "՛": "7", ")": "8", "օ": "9", "է": "0","ղ": "և"
            ]
        }
    }
    
    /**
     [rowIndex: percentage]
     */
    func rowWidthPercentageOverrides(for type: KeyboardType) -> [Int: Double] {
        switch self {
        case .phonetic:
            return [:]
        case .western:
            switch type {
            case .alphabetic(_):
                return [2: 0.0909]
            case _:
                return [:]
            }
        case .hmQwerty:
            return [:]
        case .typewriter:
            switch type {
            case .alphabetic(_):
                return [0: 0.0909, 1: 0.0769230769, 2: 0.0909]
            case _:
                return [:]
            }
        }
    }
}
