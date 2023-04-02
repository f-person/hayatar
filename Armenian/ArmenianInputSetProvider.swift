//
//  ArmenianInputSetProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import Foundation
import KeyboardKit

public class ArmenianInputSetProvider: InputSetProvider, LocalizedService {
    public init(alphabetic: AlphabeticInputSet = .armenianPhonetic) {
        self.alphabeticInputSet = alphabetic
        self.numericInputSet = .armenian()
        self.symbolicInputSet = .english()
    }
    
    public let localeKey: String = KeyboardLocale.armenian.id
    
    public let alphabeticInputSet: AlphabeticInputSet
    
    public let numericInputSet: NumericInputSet
    
    public let symbolicInputSet: SymbolicInputSet
}

public extension AlphabeticInputSet {
    /**
     An Armenian phonetic input set
     */
    static let armenianPhonetic = AlphabeticInputSet(rows: [
        .init(chars: "էթփձջրչճժծ"),
        .init(chars: "քոեռտըւիօպ"),
        .init(chars: "ասդֆգհյկլխ"),
        .init(chars: "զղցվբնմշ"),
    ])
}

public extension NumericInputSet {
    static let charAfterShift = "֊"
    static let charBeforeBackspace = "»"
    
    static func armenian() -> NumericInputSet {
        NumericInputSet(rows: [
            .init(chars: "1234567890"),
            .init(chars: "-/:;()֏&@”"),
            .init(chars: ".?!’՟ՙ՚֎‹›"),
            .init(chars: "֊—՞՛՜՝«»")
        ])
    }
}

public extension SymbolicInputSet {
    static func english() -> SymbolicInputSet {
        .standard(currencies: "€֏¥".chars)
    }
}
