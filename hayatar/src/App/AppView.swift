//
//  AppView.swift
//  hayatar
//
//  Created by arshak ‎ on 29.04.23.
//

import Foundation
import SwiftUI

struct RootView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            InstructionsView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Instructions")
                }
                .tag(0)
            
            PreferencesView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Preferences")
                }
                .tag(1)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
