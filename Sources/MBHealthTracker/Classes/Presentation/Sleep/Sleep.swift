//
//  Sleep.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation

public struct Sleep {
    
    public struct Info {

        public enum Style: Int {
            case inBed
            case asleep
            case awake
            case rem
            case core
            case deep
        }

        public let style: Style
        public let startDate: Date
        public let endDate: Date
        
        public init(style: Style, startDate: Date, endDate: Date) {
            self.style = style
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]

    public init(items: [Info]) {
        self.items = items
    }
}

