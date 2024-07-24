//
//  ContentView.swift
//  MBHealthTracker_Example
//
//  Created by Maty Brennan on 8/8/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import MBHealthTracker

struct ContentView: View {

    @StateObject private var store = Store(healthTracker: MBHealthTracker())

    var body: some View {
        Text("Content View")
            .task {
                await store.configurePermissions()
                await store.runTest()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
