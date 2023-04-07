//
//  ResetSettingsButton.swift
//  hayatar
//
//  Created by arshak ‎ on 07.04.23.
//

import Foundation
import SwiftUI
import SharedDefaults

struct ResetSettingsButton: View {
    @State private var showAlert = false
    
    var body: some View {
        Button("Restore Defaults") {
            showAlert = true
        }
        .foregroundColor(.red)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Restore Default Settings?"),
                  message: Text("Are you sure you want to restore the default settings? This action cannot be undone."),
                  primaryButton: .destructive(Text("Restore")) {
                      onReset()
                  },
                  secondaryButton: .cancel())
        }
    }
    
    func onReset() -> Void {
        SharedDefaults.resetToDefaults()
    }
}
