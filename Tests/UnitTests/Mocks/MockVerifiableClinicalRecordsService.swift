import Foundation
@testable import HealthHub

final class MockVerifiableClinicalRecordsService: VerifiableClinicalRecordsServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0

    var stubbedVerifiableClinicalRecords = VerifiableClinicalRecords(items: [])

    func verifiableClinicalRecords() async throws -> VerifiableClinicalRecords {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedVerifiableClinicalRecords
    }
}
