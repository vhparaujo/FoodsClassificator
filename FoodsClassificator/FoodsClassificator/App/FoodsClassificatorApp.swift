//
//  FoodsClassificatorApp.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 24/02/24.
//

import SwiftUI
import TipKit

@main
struct FoodsClassificatorApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                HomeView()
                TutorialHomeView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
