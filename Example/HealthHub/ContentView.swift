//
//  ContentView.swift
//  HealthHub_Example
//
//  Created by Maty Brennan on 8/8/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import HealthHub

struct ContentView: View {

    private let store = Store(hub: HealthHub())

    var body: some View {
        Text("Content View")
            .task {
                await store.configurePermissions()
                await store.runTest()
            }
    }
}

#Preview {
    ContentView()
}
