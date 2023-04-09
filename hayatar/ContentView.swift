//
//  ContentView.swift
//  hayatar
//
//  Created by arshak ‎ on 25.03.23.
//

import SwiftUI
import SharedDefaults

struct ContentView: View {
    @State private var showResetAlert = false
    @State private var showSyncConfirmationAlert = false
    
    @State private var defaults: SharedDefaults
    init() {
        defaults = SharedDefaults(canReadCloud: true)
        defaults.maybeFetchCloudPreferences()
    }
    
    var body: some View {
        return NavigationStack {
            Form {
                Section("Feedback") {
                    Toggle(isOn: Binding(
                        get: { defaults.enableHapticFeedback },
                        set: { defaults.enableHapticFeedback = $0 }
                    )) {
                        Text("Haptic Feedback")
                    }
                    Toggle(isOn: Binding(
                        get: { defaults.enableAudioFeedback },
                        set: { defaults.enableAudioFeedback = $0 }
                    )) {
                        Text("Input Sound")
                    }
                }
                
                Section("Layout") {
                    LabelledTextField(title: "Callout characters for \",\"", text: Binding(
                        get: { defaults.commaCalloutCharacters },
                        set: { defaults.commaCalloutCharacters = $0 }
                    ))
                    LabelledTextField(title: "Callout characters for \"։\"", text: Binding(
                        get: { defaults.colonCalloutCharacters },
                        set: { defaults.colonCalloutCharacters = $0 }
                    ))
                }
                
                SyncSettingsView(defaults: defaults)
                
                Section {
                    ResetSettingsButton(onReset: {
                        defaults.resetToDefaults()
                        // Update the view by reinitializing defaults
                        defaults = SharedDefaults(canReadCloud: true)
                    })
                }
            }.navigationTitle("Armenian Keyboard")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
