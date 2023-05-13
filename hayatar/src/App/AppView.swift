//
//  AppView.swift
//  hayatar
//
//  Created by arshak ‎ on 29.04.23.
//

import Foundation
import SwiftUI

class SelectionData: ObservableObject {
    @Published var selection = 0
}

struct AppView: View {
    @StateObject private var selectionData = SelectionData()
    
    var body: some View {
        TabView(selection: $selectionData.selection) {
            AboutView()
                .environmentObject(selectionData)
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("About")
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

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
