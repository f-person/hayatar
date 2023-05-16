//
//  ContentView.swift
//  hayatar
//
//  Created by arshak ‎ on 25.03.23.
//

import SwiftUI
import SharedDefaults

struct PreferencesView: View {
    @State private var tempSelectedDictionary: SpellCheckDictionary
    @State private var tempSelectedLayout: SLayout
    @State private var defaults: SharedDefaults
    
    init() {
        let sharedDefaults = SharedDefaults(canAccessCloud: true)
        defaults = sharedDefaults
        self.tempSelectedDictionary = SpellCheckDictionary(rawValue: sharedDefaults.spellCheckDictionary.value)!
        self.tempSelectedLayout = SLayout(rawValue: sharedDefaults.layout.value)!
        
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
                    Picker("Keyboard Layout", selection: $tempSelectedLayout) {
                        ForEach(Layout.allCases, id: \.self) { layout in
                            Text(layout.name).tag(layout.rawValue)
                        }
                    }.onChange(of: tempSelectedLayout) {
                        defaults.layout.value = $0.rawValue
                    }
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
                    Picker("Dictionary", selection: $tempSelectedDictionary) {
                        ForEach(SpellCheckDictionary.allCases, id: \.self) { dictionary in
                            Text("\(dictionary.name)\n(\(dictionary.totalWords) words)").tag(dictionary.rawValue)
                        }
                    }.onChange(of: tempSelectedDictionary) {
                        defaults.spellCheckDictionary.value = $0.rawValue
                    }
                }
                
                SyncSettingsView(defaults: defaults)
                
                Section {
                    ResetSettingsButton(onReset: {
                        defaults.resetToDefaults()
                        // Update the view by reinitializing defaults
                        defaults = SharedDefaults(canAccessCloud: true)
                        self.tempSelectedDictionary = SpellCheckDictionary(rawValue: defaults.spellCheckDictionary.value)!
                    })
                }
            }.navigationTitle("Preferences")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
