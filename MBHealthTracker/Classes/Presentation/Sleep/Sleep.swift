//
//  Sleep.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public struct Sleep {
    
    public struct Info {
        public let style: MBSleepStyle
        public let startDate: Date
        public let endDate: Date
        
        public init(style: MBSleepStyle, startDate: Date, endDate: Date) {
            self.style = style
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

extension Sleep.Info {
    
    public init(style: MBSleepStyle, startDate: Date) {
        self.style = style
        self.startDate = startDate
        self.endDate = Date()
    }
}

