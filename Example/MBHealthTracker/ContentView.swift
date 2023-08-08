//
//  ContentView.swift
//  MBHealthTracker_Example
//
//  Created by Maty Brennan on 8/8/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var store: Store

    init() {
        let myStore = Store()
        self._store = StateObject(wrappedValue: myStore)
    }

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
