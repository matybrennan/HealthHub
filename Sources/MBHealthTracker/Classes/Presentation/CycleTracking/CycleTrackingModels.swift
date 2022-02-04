//
//  CycleTrackingModels.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public struct GenericCycleTrackingModel {
    
    public struct Item {
        
        public enum Style: Int {
            case present = 0
            case notPresent
            case mild
            case moderate
            case severe
            
            public var name: String {
                switch self {
                case .present: return "Present"
                case .notPresent: return "Not Present"
                case .mild: return "Mild"
                case .moderate: return "Moderate"
                case .severe: return "Severe"
                }
            }
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
    
    public let items: [Item]
}

public struct AppetiteChanges {
    
    public struct Item {
        
        public enum AppetiteChangesType: Int {
            case present = 0
            case noChange
            case decreased
            case increased
            
            public var name: String {
                switch self {
                case .present: return "Present"
                case .noChange: return "No Change"
                case .decreased: return "Decreased"
                case .increased: return "Increased"
                }
            }
        }
        
        public let type: AppetiteChangesType
        public let startDate: Date
        public let endDate: Date
        
        public init(type: AppetiteChangesType, startDate: Date, endDate: Date) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Item]
}

public struct CervicalMucusQuality {
    
    public struct Info {
        
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
        
        let type: MucusType
        public let startDate: Date
        public let endDate: Date
        
        public init(type: MucusType, startDate: Date, endDate: Date) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

public struct MenstrualFlow {
    
    public struct Info {
        
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
        
        let type: FlowType
        let isStartOfCycle: Bool
        public let startDate: Date
        public let endDate: Date
        
        public init(type: FlowType, isStartOfCycle: Bool, startDate: Date, endDate: Date) {
            self.type = type
            self.isStartOfCycle = isStartOfCycle
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

public struct Ovulation {
    
    public struct Info {
        
        public enum ResultType: Int {
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
        
        let type: ResultType
        public let startDate: Date
        public let endDate: Date
        
        public init(type: ResultType, startDate: Date, endDate: Date) {
            self.type = type
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

public struct SexualActivity {
    
    public struct Info {
        
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
    
    public let items: [Info]
}

public struct Spotting {
    
    public struct Info {
        
        public let startDate: Date
        public let endDate: Date
        
        public init(startDate: Date, endDate: Date) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    public let items: [Info]
}

