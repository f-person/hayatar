//
//  ArmenianInputSetProvider.swift
//  Armenian
//
//  Created by arshak ‎ on 25.03.23.
//

import Foundation
import KeyboardKit

/**
 This input set provider returns standard English input sets.
 
 Since currencies can vary between English keyboards, we can
 override the currency symbols that are shown in the numeric
 and symbolic keyboards.
 
 KeyboardKit Pro adds a provider for each ``KeyboardLocale``
 Check out the Pro demo app to see them in action.
 */
public class ArmenianInputSetProvider: InputSetProvider, LocalizedService {
    
    /**
     Create an English input set provider.

     This input set supports QWERTY, QWERTZ and AZERTY, with
     QWERTY being the default.
     
     - Parameters:
       - alphabetic: The alphabetic input set to use, by default ``AlphabeticInputSet/english``.
       - numericCurrency: The currency to use for the numeric input set, by default `$`.
       - symbolicCurrency: The currency to use for the symbolic input set, by default `£`.
     */
    public init(
        alphabetic: AlphabeticInputSet = .armenianPhonetic,
//        alphabetic: AlphabeticInputSet = .qwerty,
        numericCurrency: String = "֏",
        symbolicCurrency: String = "£"
    ) {
        self.alphabeticInputSet = alphabetic
        self.numericInputSet = .english(currency: numericCurrency)
        self.symbolicInputSet = .english(currency: symbolicCurrency)
    }
    
    /**
     The locale identifier.
     */
    public let localeKey: String = KeyboardLocale.armenian.id
    
    /**
     The input set to use for alphabetic keyboards.
     */
    public let alphabeticInputSet: AlphabeticInputSet
    
    /**
     The input set to use for numeric keyboards.
     */
    public let numericInputSet: NumericInputSet
    
    /**
     The input set to use for symbolic keyboards.
     */
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

