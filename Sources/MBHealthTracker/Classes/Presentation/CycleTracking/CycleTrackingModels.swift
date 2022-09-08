//
//  CycleTrackingModels.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public struct CervicalMucusQuality {
    
    public struct Item {
        
        public enum MucusType: Int {
            case dry = 1
            case sticky
            case creamy
            case watery
            case eggWhite
            
            public var name: String {
                switch self {
                case .dry: return "Dry"
                case .sticky: return "Sticky"
                case .creamy: return "Creamy"
                case .watery: return "Watery"
                case .eggWhite: return "Egg white"
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
}

public struct MenstrualFlow {
    
    public struct Item {
        
        public enum FlowType: Int {
            case unspecified = 1
            case light
            case medium
            case heavy
            case none
            
            public var name: String {
                switch self {
                case .unspecified: return "Unspecified Flow"
                case .light: return "Light"
                case .medium: return "Medium"
                case .heavy: return "Heavy"
                case .none: return "No Flow"
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
}

public enum CycleResultType: Int {
    case negative = 1
    case positive
    case indetermined
    case high
    
    public var name: String {
        switch self {
        case .negative: return "Negative"
        case .positive: return "Positive"
        case .indetermined: return "Indetermined"
        case .high: return "High"
        }
    }
}

public struct Ovulation {
    
    public struct Item {
        
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
}

public struct PregnancyTestResult {
    
    public struct Item {
        
        public let type: CycleResultType
        public let date: Date
        
        public init(type: CycleResultType, date: Date) {
            self.type = type
            self.date = date
        }
    }
    
    public let items: [Item]
}

public struct ProgesteroneTestResult {
    
    public struct Item {
        
        public let type: CycleResultType
        public let date: Date
        
        public init(type: CycleResultType, date: Date) {
            self.type = type
            self.date = date
        }
    }
    
    public let items: [Item]
}

public struct SexualActivity {
    
    public struct Item {
        
        public enum StyleType: Int {
            case unspecified = -1
            case protectionUsed
            case protectionNotUsed
            
            public var name: String {
                switch self {
                case .unspecified: return "Unspecified"
                case .protectionUsed: return "Protection used"
                case .protectionNotUsed: return "Protection not used"
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
}

public struct Spotting {
    
    public struct Item {
        
        public let startDate: Date
        public let endDate: Date
        
        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]
}

