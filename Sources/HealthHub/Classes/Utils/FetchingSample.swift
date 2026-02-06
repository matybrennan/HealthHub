//
//  FetchingSample.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/9/2022.
//

import HealthKit

protocol FetchQuantitySample {
    func fetchQuantitySamples(quantityIdentifier: HKQuantityTypeIdentifier, predicate: NSPredicate?, sortDescriptors: [SortDescriptor<HKQuantitySample>], limit: Int?) async throws -> [HKQuantitySample]
}

extension FetchQuantitySample {
    func fetchQuantitySamples(quantityIdentifier: HKQuantityTypeIdentifier, predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor<HKQuantitySample>] = [], limit: Int? = nil) async throws -> [HKQuantitySample] {
        let type = try HealthParser.quantityType(for: quantityIdentifier)
        let descriptor = HKSampleQueryDescriptor(predicates: [.quantitySample(type: type, predicate: predicate)], sortDescriptors: sortDescriptors, limit: limit)
        return try await descriptor.result(for: HealthStoreProvider.shared)
    }
}

protocol FetchCategorySample {
    func fetchCategorySamples(categoryIdentifier: HKCategoryTypeIdentifier, sortDescriptors: [SortDescriptor<HKCategorySample>], limit: Int?) async throws -> [HKCategorySample]
}

extension FetchCategorySample {
    func fetchCategorySamples(categoryIdentifier: HKCategoryTypeIdentifier, sortDescriptors: [SortDescriptor<HKCategorySample>] = [], limit: Int? = nil) async throws -> [HKCategorySample] {
        let type = try HealthParser.categoryType(for: categoryIdentifier)
        let descriptor = HKSampleQueryDescriptor(predicates: [.categorySample(type: type)], sortDescriptors: sortDescriptors, limit: limit)
        return try await descriptor.result(for: HealthStoreProvider.shared)
    }
}

protocol FetchCorrelationSample {
    func fetchCorrelationSamples(correlationIdentifier: HKCorrelationTypeIdentifier, sortDescriptors: [SortDescriptor<HKCorrelation>], limit: Int?) async throws -> [HKCorrelation]
}

extension FetchCorrelationSample {
    func fetchCorrelationSamples(correlationIdentifier: HKCorrelationTypeIdentifier, sortDescriptors: [SortDescriptor<HKCorrelation>] = [], limit: Int? = nil) async throws -> [HKCorrelation] {
        let type = try HealthParser.correlationType(for: correlationIdentifier)
        let descriptor = HKSampleQueryDescriptor(predicates: [.correlation(type: type)], sortDescriptors: sortDescriptors, limit: limit)
        return try await descriptor.result(for: HealthStoreProvider.shared)
    }
}

protocol FetchWorkoutSample {
    func fetchWorkoutSamples(workoutIdentifier: HKWorkoutType, predicate: NSPredicate?, sortDescriptors: [SortDescriptor<HKWorkout>], limit: Int?) async throws -> [HKWorkout]
}

extension FetchWorkoutSample {
    func fetchWorkoutSamples(workoutIdentifier: HKWorkoutType, predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor<HKWorkout>] = [], limit: Int? = nil) async throws -> [HKWorkout] {
        let _ = try HealthParser.workoutTypeAndCheckIfAvailable()
        let descriptor = HKSampleQueryDescriptor(predicates: [.workout(predicate)], sortDescriptors: sortDescriptors, limit: limit)
        return try await descriptor.result(for: HealthStoreProvider.shared)
    }
}


