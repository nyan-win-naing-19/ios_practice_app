//
//  WanderlustVietnamApp.swift
//  WanderlustVietnam
//
//  Created by Nyan Win Naing on 13/09/2026.
//

import SwiftUI
import SwiftData

@main
struct WanderlustVietnamApp: App {
    @AppStorage("isDarkMode")
    private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .preferredColorScheme(
                    isDarkMode ? .dark : .light
                )
        }
        .modelContainer(
            for: SavedDestination.self
        )
    }
}
