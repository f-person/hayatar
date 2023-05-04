//
//  AboutView.swift
//  hayatar
//
//  Created by arshak ‎ on 29.04.23.
//

import Foundation
import SwiftUI

struct InstructionsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("How to Add the Keyboard")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Go to your device's Settings app.")
                    
                    Text("Scroll down and tap on \"General\".")
                    
                    Text("Tap on \"Keyboard\".")
                    
                    Group {
                        Text("Tap on \"Keyboards\" at the top of the screen.")
                        
                        Text("Tap on \"Add New Keyboard...\".")
                        Text("Find and select the custom keyboard from the list.")
                    }
                }
                .padding()
            }
            .navigationBarTitle("Instructions", displayMode: .inline)
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
