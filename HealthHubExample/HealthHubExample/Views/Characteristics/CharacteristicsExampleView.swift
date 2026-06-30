//
//  CharacteristicsExampleView.swift
//  HealthHubExample
//
//  Created by Maty Brennan on 30/6/2026.
//

import SwiftUI
import HealthHub

struct CharacteristicsExampleView: View {
    let store: Store

    var body: some View {
        List {
            Section("Profile") {
                row("Biological Sex", store.manager.characteristics.biologicalSex.name)
                row("Blood Type", store.manager.characteristics.bloodType.name)
                row("Skin Type", store.manager.characteristics.skinType.name)
                row("Wheelchair User", store.manager.characteristics.isWheelChairUser.name)
                row("Move Mode", store.manager.characteristics.activityMoveMode.name)

                if let dob = store.manager.characteristics.dateOfBirth {
                    let calendar = Calendar.current
                    if let date = calendar.date(from: dob) {
                        row("Date of Birth", date.formatted(date: .abbreviated, time: .omitted))
                    }
                }
            }
        }
        .navigationTitle("Characteristics")
    }

    private func row(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}
