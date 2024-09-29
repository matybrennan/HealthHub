//
//  MainApp.swift
//  HealthHub_Example
//
//  Created by Maty Brennan on 8/8/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import HealthHub

@main
struct MainApp: App {

    @StateObject private var hub = HealthHub()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(hub)
        }
    }
}
