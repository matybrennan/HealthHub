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

    func requestAuthorization(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws {
        //
    }
}

