//
//  SeuxalActivityCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
import HealthKit

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
}
