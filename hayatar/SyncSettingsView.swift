//
//  SyncSettingsView.swift
//  hayatar
//
//  Created by arshak ‎ on 08.04.23.
//

import SwiftUI
import SharedDefaults

struct SyncSettingsView: View {
    private let defaults: SharedDefaults
    init(defaults: SharedDefaults) {
        self.defaults = defaults
        self.tempEnableSync = defaults.enableSync
    }
    
    @State private var tempEnableSync: Bool
    @State private var currentAlert: ActiveAlert = .none
    
    private func setEnableSync(to value: Bool) {
        tempEnableSync = value
        defaults.enableSync = value
        currentAlert = .none
    }
    
    enum ActiveAlert {
        case none, syncConfirmation, error
    }
    
    var body: some View {
        Section("Synchronization") {
            Toggle("Sync preferences via iCloud", isOn: $tempEnableSync)
                .onChange(of: tempEnableSync) { newValue in
                    print("newValue: \(newValue); temp: \(tempEnableSync); enableSync: \(defaults.enableSync)")
                    if newValue != defaults.enableSync {
                        if FileManager.default.ubiquityIdentityToken != nil {
                            currentAlert = .syncConfirmation
                        } else {
                            currentAlert = .error
                        }
                    }
                }
                .alert(isPresented: Binding(get: { currentAlert != .none }, set: { _ in })) {
                    switch currentAlert {
                    case .syncConfirmation:
                        return Alert(
                            title: Text("Change Sync Preferences?"),
                            message: Text("Are you sure you want to \(tempEnableSync ? "enable" : "disable") sync via iCloud?"),
                            primaryButton: .default(Text("Yes")) {
                                setEnableSync(to: tempEnableSync)
                            },
                            secondaryButton: .cancel(Text("No")) {
                                setEnableSync(to: defaults.enableSync)
                            }
                        )
                    case .error:
                        return Alert(
                            title: Text("iCloud Unavailable"),
                            message: Text("iCloud is not available on this device. Please log in to your iCloud account and try again."),
                            dismissButton: .default(Text("OK")) {
                                currentAlert = .none
                            }
                        )
                    default:
                        return Alert(title: Text("Unknown error"))
                    }
                }
        }
    }
}

struct SyncSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SyncSettingsView(
            defaults: SharedDefaults(canReadCloud: false)
        )
    }
}
