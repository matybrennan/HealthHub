import Foundation
import HealthKit
@testable import HealthHub

final class MockSymptomsService: SymptomsServiceProtocol {

    var shouldThrowError: Error?
    var symptomCallCount = 0
    var saveCallCount = 0
    var lastReceivedSymptomType: SymptomType?
    var stubbedSymptom = GenericSymptomModel(items: [], type: HKCategoryType(.abdominalCramps))
    var stubbedAppetiteChanges = AppetiteChanges(items: [])

    func symptom(type: SymptomType) async throws -> GenericSymptomModel {
        symptomCallCount += 1
        lastReceivedSymptomType = type
        if let error = shouldThrowError { throw error }
        return stubbedSymptom
    }

    func appetiteChanges() async throws -> AppetiteChanges {
        symptomCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedAppetiteChanges
    }

    func saveSymptom(type: SymptomType, model: GenericSymptomModel, extra: [String: Sendable]?) async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }

    func saveAppetiteChanges(model: AppetiteChanges, extra: [String: Sendable]?) async throws {
        saveCallCount += 1
        if let error = shouldThrowError { throw error }
    }
}
