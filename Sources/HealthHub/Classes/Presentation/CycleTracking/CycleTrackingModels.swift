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
        
        let type: StyleType
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
}

