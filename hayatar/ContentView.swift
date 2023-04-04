//
//  ContentView.swift
//  hayatar
//
//  Created by arshak ‎ on 25.03.23.
//

import SwiftUI

struct ContentView: View {
    /**
     The shared store between the app view and the extension.
     */
    static private var sharedStore: UserDefaults? {
        UserDefaults(suiteName: "group.dev.fperson.hayatar.shared")
    }
    
    @AppStorage("enableHapticFeedback", store: sharedStore)
    var enableHapticFeedback = true
    
    @AppStorage("enableAudioFeedback", store: sharedStore)
    var enableAudioFeedback = true
    
    var body: some View {
        return NavigationStack {
            VStack {
                Form {
                    Section("Preferences") {
                        Toggle(isOn: $enableHapticFeedback) {
                            Text("Haptic Feedback")
                        }
                        Toggle(isOn: $enableAudioFeedback) {
                            Text("Audio Feedback")
                        }
                    }
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
