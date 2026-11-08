//
//  File.swift
//  HealthHub
//
//  Created by Maty Brennan on 29/9/2024.
//

import Foundation
@testable import HealthHub
import HealthKit

final class HealthStoreMock: HealthStoreProtocol {

    var requestStatus: HKAuthorizationRequestStatus = .unknown
    var requestAuthorizationCallCount = 0

    func requestAuthorization(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws {
        requestAuthorizationCallCount += 1
    }

    func statusForAuthorizationRequest(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws -> HKAuthorizationRequestStatus {
        requestStatus
    }
}
