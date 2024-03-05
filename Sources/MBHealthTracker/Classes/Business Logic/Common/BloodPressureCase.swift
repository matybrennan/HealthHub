//
//  BloodPressureCase.swift
//
//
//  Created by Maty Brennan on 5/3/2024.
//

import Foundation
import HealthKit

protocol BloodPressureCase: FetchCorrelationSample { }

extension BloodPressureCase {

    func baseBloodPressure() async throws -> BloodPressure {
        let bloodPressureSystolicType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodPressureSystolic)
        let bloodPressureDiastolicType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodPressureDiastolic)
        let samples = try await fetchCorrelationSamples(correlationIdentifier: .bloodPressure)
        let items = samples.compactMap { item -> BloodPressure.Info? in
            guard let systolic = item.objects(for: bloodPressureSystolicType).first as? HKQuantitySample else { return nil }
            guard let diastolic = item.objects(for: bloodPressureDiastolicType).first as? HKQuantitySample else { return nil }

            let value1 = systolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
            let value2 = diastolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())

            return BloodPressure.Info(systolic: value1, diastolic: value2, startDate: item.startDate, endDate: item.endDate)
        }

        let model = BloodPressure(items: items)
        return model
    }

    func baseSaveBloodPressure(model: BloodPressure, extra: [String : Any]?) async throws {
        let type = try MBHealthParser.unboxAndCheckIfAvailable(correlationIdentifier: .bloodPressure)
        try MBHealthParser.checkSharingAuthorizationStatus(for: type)

        let unit = HKUnit.millimeterOfMercury()
        let sampleObjects = model.items.map {
            let systolicQuantity = HKQuantity(unit: unit, doubleValue: $0.systolic)
            let diastolicQuantity = HKQuantity(unit: unit, doubleValue: $0.diastolic)

            let systolicType = HKQuantityType(.bloodPressureSystolic)
            let diastolicType = HKQuantityType(.bloodPressureDiastolic)

            let systolicSample = HKQuantitySample(type: systolicType, quantity: systolicQuantity, start: $0.startDate, end: $0.endDate)
            let diastolicSample = HKQuantitySample(type: diastolicType, quantity: diastolicQuantity, start: $0.startDate, end: $0.endDate)
            let objects: Set<HKSample> = [systolicSample, diastolicSample]

            return HKCorrelation(type: type, start: $0.startDate, end: $0.endDate, objects: objects, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
