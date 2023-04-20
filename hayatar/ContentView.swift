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
        defaults = SharedDefaults(canAccessCloud: true)
        defaults.maybeFetchCloudPreferences()
    }
    
    var body: some View {
        return NavigationStack {
            Form {
                Section("Feedback") {
                    Toggle(isOn: Binding(
                        get: { defaults.enableHapticFeedback.value },
                        set: { defaults.enableHapticFeedback.value = $0 }
                    )) {
                        Text("Haptic Feedback")
                    }
                    Toggle(isOn: Binding(
                        get: { defaults.enableAudioFeedback.value },
                        set: { defaults.enableAudioFeedback.value = $0 }
                    )) {
                        Text("Input Sound")
                    }
                }
                
                Section("Layout") {
                    Toggle(isOn: Binding(
                        get: { defaults.displayCalloutHints.value },
                        set: { defaults.displayCalloutHints.value = $0 }
                    )) {
                        Text("Display callout hints")
                    }
                    LabelledTextField(title: "Callout characters for \",\"", text: Binding(
                        get: { defaults.commaCalloutCharacters.value },
                        set: { defaults.commaCalloutCharacters.value = $0 }
                    ))
                    LabelledTextField(title: "Callout characters for \"։\"", text: Binding(
                        get: { defaults.colonCalloutCharacters.value },
                        set: { defaults.colonCalloutCharacters.value = $0 }
                    ))
                }
                
                Section("Behavior") {
                    Toggle(isOn: Binding(
                        get: { defaults.enableAutocapitalization.value },
                        set: { defaults.enableAutocapitalization.value = $0 }
                    )) {
                        Text("Autocapitalization")
                    }
                }
                
                Section("Suggestions") {
                    Toggle(isOn: Binding(
                        get: { defaults.replaceYev.value },
                        set: { defaults.replaceYev.value = $0 }
                    )) {
                        Text("Replace «և» with «եւ»")
                    }
                }
                
                SyncSettingsView(defaults: defaults)
                
                Section {
                    ResetSettingsButton(onReset: {
                        defaults.resetToDefaults()
                        // Update the view by reinitializing defaults
                        defaults = SharedDefaults(canAccessCloud: true)
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
