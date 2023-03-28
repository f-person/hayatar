//
//  ContentView.swift
//  hayatar
//
//  Created by arshak ‎ on 25.03.23.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField("Enter text", text: $text)
            .padding()
            .border(Color.gray)
            .focused($isFocused)
            .onAppear {
                self.isFocused = true
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
