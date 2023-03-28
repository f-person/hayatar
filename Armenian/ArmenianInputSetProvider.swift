//
//  ArmenianInputSetProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import Foundation
import KeyboardKit

public class ArmenianInputSetProvider: InputSetProvider, LocalizedService {
    public init(
        alphabetic: AlphabeticInputSet = .armenianPhonetic,
        numericCurrency: String = "֏",
        symbolicCurrency: String = "£"
    ) {
        self.alphabeticInputSet = alphabetic
        self.numericInputSet = .english(currency: numericCurrency)
        self.symbolicInputSet = .english(currency: symbolicCurrency)
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
    static func english(currency: String) -> NumericInputSet {
        .standard(currency: currency)
    }
}

public extension SymbolicInputSet {
    static func english(currency: String) -> SymbolicInputSet {
        .standard(currencies: "€\(currency)¥".chars)
    }
}

