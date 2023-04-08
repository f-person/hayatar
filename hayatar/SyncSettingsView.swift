//
//  SyncSettingsView.swift
//  hayatar
//
//  Created by arshak ‎ on 08.04.23.
//

import SwiftUI
import SharedDefaults

struct SyncSettingsView: View {
    @Binding var enableSync: Bool
    @State private var showSyncConfirmationAlert = false
    @State private var showErrorAlert = false

    var body: some View {
        Section("Synchronization") {
            Toggle("Sync preferences via iCloud", isOn: $enableSync)
                .onChange(of: enableSync) { newValue in
                    if newValue != SharedDefaults.enableSync {
                        if FileManager.default.ubiquityIdentityToken != nil {
                            showSyncConfirmationAlert = true
                        } else {
                            enableSync = false
                            showErrorAlert = true
                        }
                    }
                }
                .alert(isPresented: $showSyncConfirmationAlert) {
                    Alert(
                        title: Text("Change Sync Preferences?"),
                        message: Text("Are you sure you want to \(enableSync ? "enable" : "disable") sync via iCloud?"),
                        primaryButton: .default(Text("Yes")) {
                            SharedDefaults.enableSync = enableSync
                        },
                        secondaryButton: .cancel(Text("No")) {
                            enableSync = SharedDefaults.enableSync
                        }
                    )
                }
                .alert(isPresented: $showErrorAlert) {
                    Alert(
                        title: Text("iCloud Unavailable"),
                        message: Text("iCloud is not available on this device. Please log in to your iCloud account and try again."),
                        dismissButton: .default(Text("OK")) {
                            showErrorAlert = false
                        }
                    )
                }
        }
    }
}

struct SyncSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncSettingsView(enableSync: .constant(true))
    }
}
