//
//  SymptomsModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
import HealthKit

public struct GenericSymptomModel {
    
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
    public let type: HKCategoryType

    public init(items: [Item], type: HKCategoryType) {
        self.items = items
        self.type = type
    }
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

    public init(items: [Item]) {
        self.items = items
    }
}
