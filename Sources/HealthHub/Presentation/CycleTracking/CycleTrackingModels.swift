//
//  CycleTrackingModels.swift
//  HealthHub
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public struct CervicalMucusQuality: Sendable {
    
    public struct Item: Sendable {

        public enum MucusType: Int, Sendable {
            case dry = 1
            case sticky
            case creamy
            case watery
            case eggWhite
            
            public var name: String {
                switch self {
                case .dry:
                    "Dry"
                case .sticky:
                    "Sticky"
                case .creamy:
                    "Creamy"
                case .watery:
                    "Watery"
                case .eggWhite:
                    "Egg white"
                }
            }
        }
        
        public let type: MucusType
        public let startDate: Date
        public let endDate: Date
        
        public init(type: MucusType, startDate: Date, endDate: Date) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent cervical mucus quality entry
    public var mostRecent: Item? {
        items.first
    }
}

public struct Contraceptive: Sendable {

    public struct Item: Sendable {

        public enum ContraceptiveType: Int, Sendable {
            case unspecified = 1
            case implant
            case injection
            case intrauterineDevice
            case intravaginalRing
            case oral
            case patch
            
            public var name: String {
                switch self {
                case .unspecified:
                    "Unspecified"
                case .implant:
                    "Implant"
                case .injection:
                    "Injection"
                case .intrauterineDevice:
                    "Intrauterine Device (IUD)"
                case .intravaginalRing:
                    "Intravaginal Ring"
                case .oral:
                    "Oral"
                case .patch:
                    "Patch"
                }
            }
        }
        
        public let type: ContraceptiveType
        public let startDate: Date
        public let endDate: Date
        
        public init(type: ContraceptiveType, startDate: Date, endDate: Date) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent contraceptive entry
    public var mostRecent: Item? {
        items.first
    }
}

public struct Lactation: Sendable {

    public struct Item: Sendable {

        public let startDate: Date
        public let endDate: Date
        
        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of the lactation entry
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent lactation entry
    public var mostRecent: Item? {
        items.first
    }
}

public struct Pregnancy: Sendable {

    public struct Item: Sendable {

        public let startDate: Date
        public let endDate: Date
        
        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }

        /// Duration of the pregnancy entry
        public var duration: TimeInterval {
            endDate.timeIntervalSince(startDate)
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent pregnancy entry
    public var mostRecent: Item? {
        items.first
    }
}

public struct CycleNotification: Sendable {

    public enum NotificationType: Sendable {
        case infrequentMenstrualCycles
        case irregularMenstrualCycles
        case persistentIntermenstrualBleeding
        case prolongedMenstrualPeriods

        public var name: String {
            switch self {
            case .infrequentMenstrualCycles:
                "Infrequent Menstrual Cycles"
            case .irregularMenstrualCycles:
                "Irregular Menstrual Cycles"
            case .persistentIntermenstrualBleeding:
                "Persistent Intermenstrual Bleeding"
            case .prolongedMenstrualPeriods:
                "Prolonged Menstrual Periods"
            }
        }
    }

    public struct Item: Sendable {

        public let startDate: Date
        public let endDate: Date
        
        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let notificationType: NotificationType
    public let items: [Item]

    public init(notificationType: NotificationType, items: [Item]) {
        self.notificationType = notificationType
        self.items = items
    }

    /// Most recent notification
    public var mostRecent: Item? {
        items.first
    }
}

public struct Menstruation: Sendable {

    public struct Item: Sendable {

        public enum FlowType: Int, Sendable {
            case unspecified = 1
            case light
            case medium
            case heavy
            case none
            
            public var name: String {
                switch self {
                case .unspecified:
                    "Unspecified Flow"
                case .light:
                    "Light"
                case .medium:
                    "Medium"
                case .heavy:
                    "Heavy"
                case .none:
                    "No Flow"
                }
            }
        }
        
        public let type: FlowType
        public let isStartOfCycle: Bool
        public let startDate: Date
        public let endDate: Date
        
        public init(type: FlowType, isStartOfCycle: Bool, startDate: Date, endDate: Date) {
            self.type = type
            self.isStartOfCycle = isStartOfCycle
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent menstruation entry
    public var mostRecent: Item? {
        items.first
    }

    /// Items that mark the start of a new cycle
    public var cycleStarts: [Item] {
        items.filter { $0.isStartOfCycle }
    }
}

public enum CycleResultType: Int, Sendable {
    case negative = 1
    case positive
    case indetermined
    case high
    
    public var name: String {
        switch self {
        case .negative:
            "Negative"
        case .positive:
            "Positive"
        case .indetermined:
            "Indetermined"
        case .high:
            "High"
        }
    }
}

public struct Ovulation: Sendable {

    public struct Item: Sendable {

        public let type: CycleResultType
        public let startDate: Date
        public let endDate: Date
        
        public init(type: CycleResultType, startDate: Date, endDate: Date) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent ovulation test result
    public var mostRecent: Item? {
        items.first
    }

    /// Items with a positive result
    public var positiveResults: [Item] {
        items.filter { $0.type == .positive }
    }
}

public struct PregnancyTestResult: Sendable {

    public struct Item: Sendable {

        public let type: CycleResultType
        public let date: Date
        
        public init(type: CycleResultType, date: Date) {
            self.type = type
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent pregnancy test result
    public var mostRecent: Item? {
        items.first
    }

    /// Items with a positive result
    public var positiveResults: [Item] {
        items.filter { $0.type == .positive }
    }
}

public struct ProgesteroneTestResult: Sendable {

    public struct Item: Sendable {

        public let type: CycleResultType
        public let date: Date
        
        public init(type: CycleResultType, date: Date) {
            self.type = type
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent progesterone test result
    public var mostRecent: Item? {
        items.first
    }
}

public struct SexualActivity: Sendable {

    public struct Item: Sendable {

        public enum StyleType: Int, Sendable {
            case unspecified = -1
            case protectionUsed
            case protectionNotUsed
            
            public var name: String {
                switch self {
                case .unspecified:
                    "Unspecified"
                case .protectionUsed:
                    "Protection used"
                case .protectionNotUsed:
                    "Protection not used"
                }
            }
        }
        
        public let type: StyleType
        public let startDate: Date
        public let endDate: Date
        
        public init(type: StyleType, startDate: Date, endDate: Date) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent sexual activity entry
    public var mostRecent: Item? {
        items.first
    }
}

public struct Spotting: Sendable {

    public struct Item: Sendable {
        
        public let date: Date
        
        public init(date: Date) {
            self.date = date
        }
    }
    
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent spotting entry
    public var mostRecent: Item? {
        items.first
    }

    /// Total number of spotting occurrences
    public var occurrenceCount: Int {
        items.count
    }
}

