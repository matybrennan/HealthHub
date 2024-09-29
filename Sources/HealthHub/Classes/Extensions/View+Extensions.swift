//
//  File.swift
//  HealthHub
//
//  Created by Maty Brennan on 29/9/2024.
//

import SwiftUI
import HealthKitUI

extension View {

    func onHealthAccessRequest(
        toShare share: [SharableType],
        toRead read: [ReadableType],
        trigger: some Equatable,
        completion: @escaping @Sendable (Result<Bool, any Error>) -> Void
    ) -> some View {
        let shareTypes = HealthType.shareTypes(share)
        let readTypes = HealthType.readTypes(read)
        return healthDataAccessRequest(
            store: healthStore,
            shareTypes: shareTypes,
            readTypes: readTypes,
            trigger: trigger,
            completion: completion
        )
    }
}
