//
//  CardioFitnessCase.swift
//  
//
//  Created by Maty Brennan on 5/3/2024.
//

import Foundation
import HealthKit

protocol CardioFitnessCase: FetchQuantitySample { }

extension CardioFitnessCase {

    func baseCardioFitness() async throws -> CardioFitness {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .vo2Max)
        let items = samples.map { item -> CardioFitness.Item in
            let VO₂Unit = HKUnit(from: "ml/kg*min")
            let VO₂Max = item.quantity.doubleValue(for: VO₂Unit)
            return CardioFitness.Item(vo2Max: VO₂Max, date: item.endDate)
        }

        let vm = CardioFitness(items: items)
        return vm
    }

    func saveBaseCardioFitness(_ model: CardioFitness, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .vo2Max)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit(from: "ml/kg*min")
        let sampleObjects = model.items.map {
            let quantity = HKQuantity(unit: unit, doubleValue: $0.vo2Max)
            return HKQuantitySample(type: type, quantity: quantity, start: $0.date, end: $0.date, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
