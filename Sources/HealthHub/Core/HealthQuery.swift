//
//  HealthQuery.swift
//  HealthHub
//

import Foundation
import HealthKit

/// Options shared by all HealthKit sample queries.
public struct HealthQuery: Sendable {

    public enum SortOrder: Sendable {
        case newestFirst
        case oldestFirst
    }

    public let dateRange: DateRangeType
    public let limit: Int?
    public let sortOrder: SortOrder

    public init(
        dateRange: DateRangeType = .allTime,
        limit: Int? = nil,
        sortOrder: SortOrder = .newestFirst
    ) {
        self.dateRange = dateRange
        self.limit = limit
        self.sortOrder = sortOrder
    }

    func predicate() throws -> NSPredicate? {
        switch dateRange {
        case let .lastNDays(days) where days <= 0:
            throw HealthHubError.invalidQuery("lastNDays must be greater than zero")
        case let .betweenDates(start, end) where start >= end:
            throw HealthHubError.invalidQuery("The start date must be earlier than the end date")
        default:
            return try dateRange.predicate()
        }
    }

    func sortDescriptor<Sample: HKSample>() -> SortDescriptor<Sample> {
        SortDescriptor(\Sample.endDate, order: sortOrder == .newestFirst ? .reverse : .forward)
    }
}

/// A framework error with actionable HealthKit context.
public enum HealthHubError: Error, LocalizedError, Sendable, Equatable {
    case healthDataUnavailable
    case unsupportedType(String)
    case invalidQuery(String)
    case invalidAnchor
    case missingSharingAuthorization(String)

    public var errorDescription: String? {
        switch self {
        case .healthDataUnavailable:
            "Health data is not available on this device."
        case let .unsupportedType(type):
            "\(type) is not supported on the current OS version."
        case let .invalidQuery(message):
            "Invalid HealthKit query: \(message)"
        case .invalidAnchor:
            "The HealthKit query anchor could not be decoded."
        case let .missingSharingAuthorization(type):
            "Sharing authorization is required to save \(type)."
        }
    }
}

/// A value-safe representation of a HealthKit sample for lists, caching, and analytics.
public struct HealthSampleSummary: Identifiable, Sendable {

    public enum Value: Sendable, Equatable {
        case quantity(Double, unit: String)
        case category(Int)
        case workout(duration: TimeInterval)
        case unavailable
    }

    public let id: UUID
    public let typeIdentifier: String
    public let startDate: Date
    public let endDate: Date
    public let sourceBundleIdentifier: String
    public let deviceName: String?
    public let value: Value

    public init(
        id: UUID,
        typeIdentifier: String,
        startDate: Date,
        endDate: Date,
        sourceBundleIdentifier: String,
        deviceName: String? = nil,
        value: Value = .unavailable
    ) {
        self.id = id
        self.typeIdentifier = typeIdentifier
        self.startDate = startDate
        self.endDate = endDate
        self.sourceBundleIdentifier = sourceBundleIdentifier
        self.deviceName = deviceName
        self.value = value
    }

    init(sample: HKSample, unit: HKUnit?) {
        id = sample.uuid
        typeIdentifier = sample.sampleType.identifier
        startDate = sample.startDate
        endDate = sample.endDate
        sourceBundleIdentifier = sample.sourceRevision.source.bundleIdentifier
        deviceName = sample.device?.name

        if let quantitySample = sample as? HKQuantitySample, let unit {
            value = .quantity(quantitySample.quantity.doubleValue(for: unit), unit: unit.unitString)
        } else if let categorySample = sample as? HKCategorySample {
            value = .category(categorySample.value)
        } else if let workout = sample as? HKWorkout {
            value = .workout(duration: workout.duration)
        } else {
            value = .unavailable
        }
    }
}

/// A portable representation of an `HKQueryAnchor`.
public struct HealthQueryAnchor: Sendable, Equatable {
    public let data: Data

    public init(data: Data) {
        self.data = data
    }

    init(anchor: HKQueryAnchor) throws {
        data = try NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true)
    }

    func healthKitAnchor() throws -> HKQueryAnchor {
        guard let anchor = try NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: data) else {
            throw HealthHubError.invalidAnchor
        }
        return anchor
    }
}

/// Added and deleted records since a previously saved query anchor.
public struct HealthAnchoredChange: Sendable {
    public let addedSamples: [HealthSampleSummary]
    public let deletedObjectIDs: [UUID]
    public let anchor: HealthQueryAnchor
}

/// An event emitted when HealthKit reports that a sample type has changed.
public struct HealthStoreChange: Sendable, Equatable {
    public let typeIdentifier: String
    public let date: Date

    public init(typeIdentifier: String, date: Date = .now) {
        self.typeIdentifier = typeIdentifier
        self.date = date
    }
}

/// Aggregate quantity values for a query.
public struct HealthQuantityStatistics: Sendable, Equatable {
    public let typeIdentifier: String
    public let unit: String
    public let sum: Double?
    public let average: Double?
    public let minimum: Double?
    public let maximum: Double?

    public init(
        typeIdentifier: String,
        unit: String,
        sum: Double?,
        average: Double?,
        minimum: Double?,
        maximum: Double?
    ) {
        self.typeIdentifier = typeIdentifier
        self.unit = unit
        self.sum = sum
        self.average = average
        self.minimum = minimum
        self.maximum = maximum
    }
}
