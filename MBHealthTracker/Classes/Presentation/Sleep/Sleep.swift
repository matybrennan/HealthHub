//
//  Sleep.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation
import HealthKit

public struct Sleep {
    
    public struct Info {
        public let style: MBSleepStyle
        public let startDate: Date
        public let endDate: Date
        public let type: HKCategoryType
    }
    
    public let items: [Info]
}

extension Sleep.Info {
    
    public init(style: MBSleepStyle, startDate: Date, type: HKCategoryType) {
        self.style = style
        self.startDate = startDate
        self.endDate = Date()
        self.type = type
    }
}

