//
//  CDADocumentsService.swift
//  HealthHub
//
//  Created by Copilot on 7/8/2026.
//

import Foundation
import HealthKit

public final class CDADocumentsService {

    public init() { }
}

private final class CDADocumentQueryState: @unchecked Sendable {
    private let lock = NSLock()
    private var documents: [HKCDADocumentSample] = []
    private var continuation: CheckedContinuation<[HKCDADocumentSample], Error>?

    init(continuation: CheckedContinuation<[HKCDADocumentSample], Error>) {
        self.continuation = continuation
    }

    func append(_ samples: [HKDocumentSample]?) {
        guard let samples else { return }

        lock.lock()
        documents.append(contentsOf: samples.compactMap { $0 as? HKCDADocumentSample })
        lock.unlock()
    }

    func finish() {
        lock.lock()
        guard let continuation else {
            lock.unlock()
            return
        }
        let documents = self.documents
        self.continuation = nil
        lock.unlock()
        continuation.resume(returning: documents)
    }

    func fail(_ error: Error) {
        lock.lock()
        guard let continuation else {
            lock.unlock()
            return
        }
        self.continuation = nil
        lock.unlock()
        continuation.resume(throwing: error)
    }
}

private protocol FetchCDADocumentSample {
    func fetchCDADocumentSamples(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor], limit: Int?) async throws -> [HKCDADocumentSample]
}

extension FetchCDADocumentSample {
    func fetchCDADocumentSamples(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor] = [], limit: Int? = nil) async throws -> [HKCDADocumentSample] {
        try ensureHealthDataAvailable()
        let type = HKDocumentType(.CDA)

        return try await withCheckedThrowingContinuation { continuation in
            let state = CDADocumentQueryState(continuation: continuation)
            let query = HKDocumentQuery(
                documentType: type,
                predicate: predicate,
                limit: limit ?? HKObjectQueryNoLimit,
                sortDescriptors: sortDescriptors,
                includeDocumentData: true
            ) { _, results, done, error in
                if let error {
                    state.fail(error)
                    return
                }

                state.append(results)

                if done {
                    state.finish()
                }
            }
            HealthStoreProvider.shared.execute(query)
        }
    }
}

// MARK: - FetchCDADocumentSample
extension CDADocumentsService: FetchCDADocumentSample { }

// MARK: - CDADocumentsServiceProtocol
extension CDADocumentsService: CDADocumentsServiceProtocol {

    public func cdaDocuments() async throws -> CDADocument {
        let sortDescriptor = NSSortDescriptor(keyPath: \HKDocumentSample.endDate, ascending: false)
        let samples = try await fetchCDADocumentSamples(sortDescriptors: [sortDescriptor])
        let items = samples.map { item -> CDADocument.Item in
            let document = item.document
            return CDADocument.Item(
                title: document?.title,
                patientName: document?.patientName,
                authorName: document?.authorName,
                custodianName: document?.custodianName,
                documentData: document?.documentData,
                startDate: item.startDate,
                endDate: item.endDate
            )
        }

        return CDADocument(items: items)
    }
}
