//
//  ContentView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 29/9/2024.
//

import SwiftUI
import HealthHub

struct ContentView: View {

    @State private var store = Store(manager: HealthHubManager())

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
