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
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct Previews_LabelledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabelledTextField(
            title: "Titles are important",
            text: Binding.constant("Preview text")
        )
    }
}
