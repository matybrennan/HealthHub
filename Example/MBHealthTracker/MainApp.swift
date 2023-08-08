//
//  MainApp.swift
//  MBHealthTracker_Example
//
//  Created by Maty Brennan on 8/8/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import MBHealthTracker

@main
struct MainApp: App {

    @StateObject private var healthTracker = MBHealthTracker()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthTracker)
        }
    }
}
