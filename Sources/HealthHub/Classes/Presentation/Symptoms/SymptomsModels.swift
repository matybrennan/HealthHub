//
//  SymptomsModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation
import HealthKit

public struct GenericSymptomModel: Sendable {

    public struct Item: Sendable {

        public enum Style: Int, Sendable {
            case present = 0
            case notPresent
            case mild
            case moderate
            case severe
            
            public var name: String {
                switch self {
                case .present:
                    "Present"
                case .notPresent:
                    "Not Present"
                case .mild:
                    "Mild"
                case .moderate:
                    "Moderate"
                case .severe:
                    "Severe"
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

public struct AppetiteChanges: Sendable {

    public struct Item: Sendable {

        public enum AppetiteChangesType: Int, Sendable{
            case present = 0
            case noChange
            case decreased
            case increased
            
            public var name: String {
                switch self {
                case .present:
                    "Present"
                case .noChange:
                    "No Change"
                case .decreased:
                    "Decreased"
                case .increased:
                    "Increased"
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
