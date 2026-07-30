import Foundation
@testable import HealthHub

final class MockActiveEnergyService: ActiveEnergyServiceProtocol {

    var stubbedActiveEnergy = ActiveEnergy(items: [])
    var activeEnergyCallCount = 0
    var lastReceivedType: ActiveEnergyType?
    var shouldThrowError: Error?

    func activeEnergy(from type: ActiveEnergyType) async throws -> ActiveEnergy {
        activeEnergyCallCount += 1
        lastReceivedType = type
        if let error = shouldThrowError { throw error }
        return stubbedActiveEnergy
    }
}
