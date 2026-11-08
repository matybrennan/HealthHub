import Foundation
@testable import HealthHub

final class MockCDADocumentsService: CDADocumentsServiceProtocol {

    var shouldThrowError: Error?
    var fetchCallCount = 0

    var stubbedCDADocuments = CDADocument(items: [])

    func cdaDocuments() async throws -> CDADocument {
        fetchCallCount += 1
        if let error = shouldThrowError { throw error }
        return stubbedCDADocuments
    }
}
