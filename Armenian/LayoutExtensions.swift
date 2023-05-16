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
        }
        
    }
    
    func characterBeforeBackspace(_ isUppercased: Bool) -> KeyboardAction {
        switch self {
        case .phonetic:
            return .character(isUppercased ? "Շ" : "շ")
        case .western:
            return .character(isUppercased ? "Ծ" : "ծ")
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
        }
    }
}
