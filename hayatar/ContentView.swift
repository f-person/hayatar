//
//  ContentView.swift
//  hayatar
//
//  Created by arshak ‎ on 25.03.23.
//

import SwiftUI
import SharedDefaults

struct ContentView: View {
    @State private var enableHapticFeedback = SharedDefaults.enableHapticFeedback
    @State private var enableAudioFeedback = SharedDefaults.enableAudioFeedback
    @State private var commaCalloutCharacters = SharedDefaults.commaCalloutCharacters
    @State private var colonCalloutCharacters = SharedDefaults.colonCalloutCharacters
    @State private var enableSync = SharedDefaults.enableSync
    
    @State private var showResetAlert = false
    @State private var showSyncConfirmationAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Feedback") {
                    Toggle(isOn: Binding(
                        get: { enableHapticFeedback },
                        set: { enableHapticFeedback = $0; SharedDefaults.enableHapticFeedback = $0 }
                    )) {
                        Text("Haptic Feedback")
                    }
                    Toggle(isOn: Binding(
                        get: { enableAudioFeedback },
                        set: { enableAudioFeedback = $0; SharedDefaults.enableAudioFeedback = $0 }
                    )) {
                        Text("Input Sound")
                    }
                }
                
                Section("Layout") {
                    LabelledTextField(title: "Callout characters for \",\"", text: Binding(
                        get: { commaCalloutCharacters },
                        set: { commaCalloutCharacters = $0; SharedDefaults.commaCalloutCharacters = $0 }
                    ))
                    LabelledTextField(title: "Callout characters for \"։\"", text: Binding(
                        get: { colonCalloutCharacters },
                        set: { colonCalloutCharacters = $0; SharedDefaults.colonCalloutCharacters = $0 }
                    ))
                }
                
                SyncSettingsView(enableSync: $enableSync)
                
                Section {
                    ResetSettingsButton(onReset: {
                        SharedDefaults.resetToDefaults()
                        
                        enableHapticFeedback = SharedDefaults.enableHapticFeedback
                        enableAudioFeedback = SharedDefaults.enableAudioFeedback
                        commaCalloutCharacters = SharedDefaults.commaCalloutCharacters
                        colonCalloutCharacters = SharedDefaults.colonCalloutCharacters
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
