//
//  Instructions.swift
//  hayatar
//
//  Created by arshak ‎ on 13.05.23.
//

import Foundation
import SwiftUI
import KeyboardKit

struct InstructionsView: View {
    let onOk: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Open app settings with the button below")
                    
                    Button(action: {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Open Settings")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    InstructionView(iconName: "keyboard", instruction: "In Settings, tap on 'Keyboards'")
                    
                    instructionImage("instruciton_keyboards")
                    
                    InstructionView(iconName: "power", instruction: "Switch 'Armenian' on to add the keyboard")
                    
                    instructionImage("instruciton_switches")
                    
                    InstructionView(iconName: "lock.shield", instruction: "Switch 'Allow Full Access' on for the best experience")
                    Text("Hayatar doesn't collect any data and never will. You deserve privacy <3")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Button(action: onOk) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("Done")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
            .navigationTitle("Setup keyboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func instructionImage(_ name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct InstructionView: View {
    let iconName: String
    let instruction: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .imageScale(.medium)
                .foregroundColor(Color.accentColor)
            Text(instruction)
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView(onOk: {})
    }
}
