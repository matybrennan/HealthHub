//
//  HealthHubExampleApp.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 29/9/2024.
//

import SwiftUI
import HealthHub

@main
struct HealthHubExampleApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(HealthHandler())
        }
    }
}
