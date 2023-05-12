//
//  AboutView.swift
//  hayatar
//
//  Created by arshak ‎ on 29.04.23.
//

import Foundation
import SwiftUI

struct InstructionsView: View {
    let github = "https://github.com/f-person/hayatar"
    var githubIssues: String { "\(github)/issues" }
    let website = "https://hayatar.fperson.dev"
    let telegramChat = "https://t.me/hayatar_keyboard"
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Project")) {
                    HStack {
                        Image(systemName: "paperplane")
                        Link(
                            "Join the project discussion on Telegram",
                            destination: URL(string: telegramChat)!
                        )
                    }
                    HStack {
                        Image(systemName: "network")
                        Link(
                            "Website",
                            destination: URL(string: website)!
                        )
                    }
                    HStack {
                        Image(systemName: "curlybraces")
                        Link(
                            "Source Code",
                            destination: URL(string: github)!
                        )
                    }
                    HStack {
                        Image(systemName: "lightbulb")
                        Link(
                            "Issues & Feature requests",
                            destination: URL(string: githubIssues)!
                        )
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("About Hayatar")
        }
    }}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
