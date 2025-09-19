//
//  ContentView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 29/9/2024.
//

import SwiftUI
import HealthHub

struct ContentView: View {

    private let configuration = ConfigurationService(healthStore: healthStore)

    var body: some View {
        Text("Content View")
            .onAppear {
                Task {
                    try? await configuration.requestAuthorization(toShare: HealthObjectType.allCases, toRead: HealthObjectType.allCases)
                }
            }
            .onChange(of: configuration.state) { oldValue, newValue in
                print("new: \(newValue) : old: \(oldValue)")
            }
    }
}

#Preview {
    ContentView()
}
