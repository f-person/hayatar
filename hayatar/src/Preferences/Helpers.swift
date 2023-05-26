//
//  Helpers.swift
//  hayatar
//
//  Created by arshak ‎ on 26.05.23.
//

import Foundation
import SharedDefaults
import SwiftUI

extension Preference {
    func binding() -> Binding<T> {
        Binding(
            get: { self.value },
            set: { newValue in self.value = newValue }
        )
    }
}
