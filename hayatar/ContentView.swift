//
//  ContentView.swift
//  hayatar
//
//  Created by arshak ‎ on 25.03.23.
//

import SwiftUI
import SharedDefaults

struct ContentView: View {
    static private var store: UserDefaults? { SharedDefaults.userDefaultsForAppGroup() }

    @AppStorage(SharedDefaults.enableHapticFeedbackKey, store: store)
    var enableHapticFeedback = SharedDefaults.enableHapticFeedback

    @AppStorage(SharedDefaults.enableAudioFeedbackKey, store: store)
    var enableAudioFeedback = SharedDefaults.enableAudioFeedback

    @AppStorage(SharedDefaults.commaCalloutCharactersKey, store: store)
    var commaCalloutCharacters = SharedDefaults.defaultCommaCalloutCharacters

    @AppStorage(SharedDefaults.colonCalloutCharactersKey, store: store)
    var colonCalloutCharacters = SharedDefaults.defaultColonCalloutCharacters

    @State private var showResetAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Feedback") {
                    Toggle(isOn: $enableHapticFeedback) {
                        Text("Haptic Feedback")
                    }
                    Toggle(isOn: $enableAudioFeedback) {
                        Text("Input Sound")
                    }
                }
                Section("Layout") {
                    LabelledTextField(title: "Callout characters for \",\"", text: $commaCalloutCharacters)
                    LabelledTextField(title: "Callout characters for \"։\"", text: $colonCalloutCharacters)
                }
                Section {
                    ResetSettingsButton()
                }
            }.navigationTitle("Armenian Keyboard")
        }
    }

    func resetSettings() {
        // Your reset settings code goes here
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
