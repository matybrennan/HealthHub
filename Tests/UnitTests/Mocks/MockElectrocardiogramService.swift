import Foundation
import HealthKit
@testable import HealthHub

final class MockElectrocardiogramService: ElectrocardiogramServiceProtocol {

    var shouldThrowError: Error?
    var electrocardiogramCallCount = 0
    var voltageMeasurementsCallCount = 0

    var stubbedElectrocardiogram = Electrocardiogram(items: [])
    var stubbedVoltageMeasurements: [Electrocardiogram.VoltageMeasurement] = []

    func electrocardiogram() async throws -> Electrocardiogram {
        electrocardiogramCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedElectrocardiogram
    }

    func voltageMeasurements(for sample: HKElectrocardiogram) async throws -> [Electrocardiogram.VoltageMeasurement] {
        voltageMeasurementsCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedVoltageMeasurements
    }
}
