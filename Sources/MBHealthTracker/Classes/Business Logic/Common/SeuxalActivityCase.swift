//
//  SeuxalActivityCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
@preconcurrency import HealthKit

@MainActor
protocol SexualActivityCase: FetchCategorySample { }

extension SexualActivityCase {
    
    func baseSexualActivity() async throws -> SexualActivity {
        let samples = try await fetchCategorySamples(categoryIdentifier: .sexualActivity)
        let items = samples.map { item -> SexualActivity.Item in
            let styleInt = item.metadata?[HKMetadataKeySexualActivityProtectionUsed] as? Int ?? -1
            let type: SexualActivity.Item.StyleType = SexualActivity.Item.StyleType(rawValue: styleInt) ?? .unspecified
            return SexualActivity.Item(type: type, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = SexualActivity(items: items)
        return model
    }

    func saveBaseSexualActivity(_ model: SexualActivity, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .sexualActivity)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let sampleObjects = model.items.map {
            var metadata = extra ?? [:]
            metadata[HKMetadataKeySexualActivityProtectionUsed] = $0.type.rawValue
            return HKCategorySample(type: type, value: $0.type.rawValue, start: $0.startDate, end: $0.endDate, metadata: metadata)
        }

        try await healthStore.save(sampleObjects)
    }
}
