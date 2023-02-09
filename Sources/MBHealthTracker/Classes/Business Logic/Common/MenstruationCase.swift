//
//  MenstruationCase.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/2/2023.
//

import Foundation
import HealthKit

protocol MenstruationCase: FetchCategorySample { }

extension MenstruationCase {
    
    func baseMenstruation() async throws -> Menstruation {
        let samples = try await fetchCategorySamples(categoryIdentifier: .menstrualFlow)
        let items = samples.map { item -> Menstruation.Item in
            let type: Menstruation.Item.FlowType = Menstruation.Item.FlowType(rawValue: item.value) ?? .unspecified
            let cycleStartInt = item.metadata?[HKMetadataKeyMenstrualCycleStart] as? Int ?? 0
            let isStartOfCylce = (cycleStartInt == 0) ? false : true
            return Menstruation.Item(type: type, isStartOfCycle: isStartOfCylce, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = Menstruation(items: items)
        return model
    }
}
