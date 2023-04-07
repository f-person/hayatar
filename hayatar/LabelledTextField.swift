//
//  LabelledTextField.swift
//  hayatar
//
//  Created by arshak ‎ on 07.04.23.
//

import Foundation
import SwiftUI

struct LabelledTextField: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
        }
    }
}

