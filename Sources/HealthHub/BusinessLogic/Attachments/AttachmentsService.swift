//
//  AttachmentsService.swift
//  HealthHub
//
//  Created by Maty Brennan on 7/8/2026.
//

import Foundation
import HealthKit
import UniformTypeIdentifiers

public final class AttachmentsService {

    private let attachmentStore = HKAttachmentStore(healthStore: HealthStoreProvider.shared)

    public init() { }
}

// MARK: - AttachmentsServiceProtocol
extension AttachmentsService: AttachmentsServiceProtocol {

    public func addAttachment(data: Data, name: String, contentType: String, to object: HKObject) async throws -> Attachment {
        try ensureHealthDataAvailable()
        try checkSharingAuthorizationStatusIfAvailable(for: object)

        let fileURL = try makeAttachmentFileURL(contentType: contentType)
        defer { try? FileManager.default.removeItem(at: fileURL) }

        try data.write(to: fileURL, options: .atomic)
        let attachment = try await addStoredAttachment(
            to: object,
            name: name,
            contentType: UTType(importedAs: contentType),
            url: fileURL
        )

        return Attachment(attachment: attachment)
    }

    public func attachments(for object: HKObject) async throws -> [Attachment] {
        try ensureHealthDataAvailable()
        let attachments = try await storedAttachments(for: object)
        return attachments.map { Attachment(attachment: $0) }
    }

    public func attachmentContent(for attachment: Attachment, from object: HKObject) async throws -> Data {
        try ensureHealthDataAvailable()
        let storedAttachment = try await storedAttachment(for: attachment, on: object)
        return try await data(for: storedAttachment)
    }

    public func deleteAttachment(_ attachment: Attachment, from object: HKObject) async throws {
        try ensureHealthDataAvailable()
        try checkSharingAuthorizationStatusIfAvailable(for: object)

        let storedAttachment = try await storedAttachment(for: attachment, on: object)
        try await removeStoredAttachment(storedAttachment, from: object)
    }
}

private extension AttachmentsService {

    func storedAttachment(for attachment: Attachment, on object: HKObject) async throws -> HKAttachment {
        let identifier = attachment.identifier.lowercased()
        let attachments = try await storedAttachments(for: object)

        guard let storedAttachment = attachments.first(where: { $0.identifier.uuidString.lowercased() == identifier }) else {
            throw AttachmentStoreError.attachmentNotFound(attachment.identifier)
        }

        return storedAttachment
    }

    func addStoredAttachment(to object: HKObject, name: String, contentType: UTType, url: URL) async throws -> HKAttachment {
        try await withCheckedThrowingContinuation { continuation in
            attachmentStore.addAttachment(to: object, name: name, contentType: contentType, url: url) { attachment, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let attachment {
                    continuation.resume(returning: attachment)
                } else {
                    continuation.resume(throwing: AttachmentStoreError.attachmentCreationFailed(name))
                }
            }
        }
    }

    func storedAttachments(for object: HKObject) async throws -> [HKAttachment] {
        try await withCheckedThrowingContinuation { continuation in
            attachmentStore.getAttachments(for: object) { attachments, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let attachments {
                    continuation.resume(returning: attachments)
                } else {
                    continuation.resume(returning: [])
                }
            }
        }
    }

    func removeStoredAttachment(_ attachment: HKAttachment, from object: HKObject) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            attachmentStore.removeAttachment(attachment, from: object) { success, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if success {
                    continuation.resume(returning: ())
                } else {
                    continuation.resume(throwing: AttachmentStoreError.attachmentNotFound(attachment.identifier.uuidString))
                }
            }
        }
    }

    func checkSharingAuthorizationStatusIfAvailable(for object: HKObject) throws {
        guard let sample = object as? HKSample else { return }
        try HealthParser.checkSharingAuthorizationStatus(for: sample.sampleType)
    }

    func data(for attachment: HKAttachment) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            _ = attachmentStore.getData(for: attachment) { data, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: AttachmentStoreError.unableToLoadData(attachment.identifier.uuidString))
                }
            }
        }
    }

    func makeAttachmentFileURL(contentType: String) throws -> URL {
        let directory = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("HealthHubAttachments", isDirectory: true)

        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)

        let fileType = UTType(importedAs: contentType)
        let fileExtension = fileType.preferredFilenameExtension.map { ".\($0)" } ?? ""
        return directory.appendingPathComponent(UUID().uuidString + fileExtension)
    }
}

private enum AttachmentStoreError: LocalizedError {
    case attachmentNotFound(String)
    case attachmentCreationFailed(String)
    case unableToLoadData(String)

    var errorDescription: String? {
        switch self {
        case let .attachmentNotFound(identifier):
            "Unable to find attachment with identifier \(identifier)."
        case let .attachmentCreationFailed(name):
            "Unable to create attachment named \(name)."
        case let .unableToLoadData(identifier):
            "Unable to load data for attachment with identifier \(identifier)."
        }
    }
}

private extension Attachment {
    init(attachment: HKAttachment) {
        self.init(
            identifier: attachment.identifier.uuidString,
            name: attachment.name,
            contentType: attachment.contentType.identifier,
            size: Int64(attachment.size)
        )
    }
}
