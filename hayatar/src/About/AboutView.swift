//
//  AboutView.swift
//  hayatar
//
//  Created by arshak ‎ on 29.04.23.
//

import Foundation
import SwiftUI

struct AboutView: View {
    let github = "https://github.com/f-person/hayatar"
    var githubIssues: String { "\(github)/issues" }
    let website = "https://hayatar.fperson.dev"
    let telegramChat = "https://t.me/hayatar_keyboard"
    let fpersonLink = "https://github.com/f-person"
    
    @EnvironmentObject var selectionData: SelectionData
    @AppStorage("isBottomSheetPresented") private var isBottomSheetPresented = true
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Keyboard")) {
                    Button(action: {
                        isBottomSheetPresented = true
                    }) {
                        HStack {
                            Image(systemName: "keyboard")
                                .foregroundColor(Color.primary)
                            Text("Show setup instructions").foregroundColor(Color.accentColor)
                        }
                    }
                    .sheet(isPresented: $isBottomSheetPresented) {
                        InstructionsView (onOk: {
                            isBottomSheetPresented = false
                        })
                    }
                    Button (action: {
                        selectionData.selection = 1
                    }) {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(Color.primary)
                            Text("Customize").foregroundColor(Color.accentColor)
                        }
                    }
                }
                
                Section(header: Text("Project")) {
                    HStack {
                        Image(systemName: "paperplane")
                        Link(
                            "Join project discussion on Telegram",
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
                
                Link(
                    "Made with lots of ❤️\u{00A0}and\u{00A0}🍵\nin Yerevan\u{00A0}🇦🇲 by\u{00A0}f-person",
                    destination: URL(string: fpersonLink)!
                )
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.indigo)
                .listRowBackground(Color.clear)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("About Hayatar")
        }
    }}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
