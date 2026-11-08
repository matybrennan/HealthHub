import Foundation
@testable import HealthHub

final class MockMedicationsService: MedicationsServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0

    var stubbedMedications = Medications(items: [])

    func medications() async throws -> Medications {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedMedications
    }
}
