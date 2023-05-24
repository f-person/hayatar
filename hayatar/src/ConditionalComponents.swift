//
//  ConditionalNavigationView.swift
//  Armenian
//
//  Created by arshak ‎ on 24.05.23.
//

import Foundation
import SwiftUI

struct ConditionalNavigationView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @ViewBuilder
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { content }
        } else {
            NavigationView { content }
        }
    }
}

struct ConditionalButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content.buttonStyle(.borderedProminent)
        } else {
            content.buttonStyle(.plain)
        }
    }
}

