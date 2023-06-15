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
        return ConditionalNavigationView {
            Form {
                Section(header: Text("Feedback")) {
                    Toggle(isOn: defaults.enableHapticFeedback.binding()) {
                        Text("Haptic Feedback")
                    }
                    Toggle(isOn: defaults.enableAudioFeedback.binding()) {
                        Text("Input Sound")
                    }
                }
                
                Section(header: Text("Layout")) {
                    Picker("Keyboard Layout", selection: $tempSelectedLayout) {
                        // Temporarily hide hmQwerty until it's ready
                        ForEach(Layout.allCases.filter {$0 != Layout.hmQwerty} , id: \.self) { layout in
                            Text(layout.name).tag(layout.rawValue)
                        }
                    }
                    .onChange(of: tempSelectedLayout) {
                        defaults.layout.value = $0.rawValue
                    }
                    Toggle(isOn: defaults.displayCalloutHints.binding()) {
                        Text("Display callout hints")
                    }
                    LabelledTextField(title: "\",\" replacement (e.g. with \"և\")", text: defaults.commaReplacement.binding())
                    LabelledTextField(title: "Callout characters for \",\"", text: defaults.commaCalloutCharacters.binding())
                    LabelledTextField(title: "Callout characters for \"։\"", text: defaults.colonCalloutCharacters.binding())
                }
                
                Section(header: Text("Behavior")) {
                    Toggle(isOn: defaults.enableAutocapitalization.binding()) {
                        Text("Autocapitalization")
                    }
                }
                
                Section(header: Text("Suggestions")) {
                    Toggle(isOn: defaults.enableSuggestions.binding()) {
                        Text("Enable suggestions")
                    }
                    Toggle(isOn: defaults.replaceYev.binding()) {
                        Text("Replace «և» with «եւ»")
                    }
                    Picker("Dictionary", selection: $tempSelectedDictionary) {
                        ForEach(SpellCheckDictionary.allCases, id: \.self) { dictionary in
                            Text("\(dictionary.name)\n(\(dictionary.totalWords) words)").tag(dictionary.rawValue)
                        }
                    }
                    .onChange(of: tempSelectedDictionary) {
                        defaults.spellCheckDictionary.value = $0.rawValue
                    }
                    .pickerStyle(conditionalNavigationPickerStyle)
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
