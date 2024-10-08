//
//  FetchingSample.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/9/2022.
//

@preconcurrency import HealthKit

protocol FetchQuantitySample: Sendable {
    func fetchQuantitySamples(quantityIdentifier: HKQuantityTypeIdentifier, predicate: NSPredicate?, sortDescriptors: [SortDescriptor<HKQuantitySample>], limit: Int?) async throws -> [HKQuantitySample]
}

extension FetchQuantitySample {
    func fetchQuantitySamples(quantityIdentifier: HKQuantityTypeIdentifier, predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor<HKQuantitySample>] = [], limit: Int? = nil) async throws -> [HKQuantitySample] {
        let quantityType = try HealthParser.unboxAndCheckIfAvailable(quantityIdentifier: quantityIdentifier)
        let queryDescriptor = HKSampleQueryDescriptor(predicates: [.quantitySample(type: quantityType, predicate: predicate)], sortDescriptors: sortDescriptors, limit: limit)
        let samples = try await queryDescriptor.result(for: healthStore)
        return samples
    }
}

protocol FetchCategorySample: Sendable {
    func fetchCategorySamples(categoryIdentifier: HKCategoryTypeIdentifier, sortDescriptors: [SortDescriptor<HKCategorySample>], limit: Int?) async throws -> [HKCategorySample]
}

extension FetchCategorySample {
    func fetchCategorySamples(categoryIdentifier: HKCategoryTypeIdentifier, sortDescriptors: [SortDescriptor<HKCategorySample>] = [], limit: Int? = nil) async throws -> [HKCategorySample] {
        let categoryType = try HealthParser.unboxAndCheckIfAvailable(categoryIdentifier: categoryIdentifier)
        let queryDescriptor = HKSampleQueryDescriptor(predicates: [.categorySample(type: categoryType)], sortDescriptors: sortDescriptors, limit: limit)
        let samples = try await queryDescriptor.result(for: healthStore)
        return samples
    }
}

protocol FetchCorrelationSample: Sendable {
    func fetchCorrelationSamples(correlationIdentifier: HKCorrelationTypeIdentifier, sortDescriptors: [SortDescriptor<HKCorrelation>], limit: Int?) async throws -> [HKCorrelation]
}

extension FetchCorrelationSample {
    func fetchCorrelationSamples(correlationIdentifier: HKCorrelationTypeIdentifier, sortDescriptors: [SortDescriptor<HKCorrelation>] = [], limit: Int? = nil) async throws -> [HKCorrelation] {
        let correlationType = try HealthParser.unboxAndCheckIfAvailable(correlationIdentifier: correlationIdentifier)
        let queryDescriptor = HKSampleQueryDescriptor(predicates: [.correlation(type: correlationType)], sortDescriptors: sortDescriptors, limit: limit)
        let samples = try await queryDescriptor.result(for: healthStore)
        return samples
    }
}

protocol FetchWorkoutSample: Sendable {
    func fetchWorkoutSamples(workoutIdentifier: HKWorkoutType, predicate: NSPredicate?, sortDescriptors: [SortDescriptor<HKWorkout>], limit: Int?) async throws -> [HKWorkout]
}

extension FetchWorkoutSample {
    func fetchWorkoutSamples(workoutIdentifier: HKWorkoutType, predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor<HKWorkout>] = [], limit: Int? = nil) async throws -> [HKWorkout] {
        let _ = try HealthParser.workoutTypeAndCheckIfAvailable()
        let queryDescriptor = HKSampleQueryDescriptor(predicates: [.workout(predicate)], sortDescriptors: sortDescriptors, limit: limit)
        let samples = try await queryDescriptor.result(for: healthStore)
        return samples
    }
}


