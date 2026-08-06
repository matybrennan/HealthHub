//
//  VisionPrescriptionModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 8/7/2026.
//

import Foundation
import HealthKit

/// Common lens correction values shared by glasses and contact lens prescriptions.
public struct LensSpecification: Sendable {
    public let sphere: Double // diopters
    public let cylinder: Double? // diopters
    public let axis: Double? // degrees
    public let addPower: Double? // diopters

    public init(sphere: Double, cylinder: Double? = nil, axis: Double? = nil, addPower: Double? = nil) {
        self.sphere = sphere
        self.cylinder = cylinder
        self.axis = axis
        self.addPower = addPower
    }
}

/// Prism correction for double vision, attached to a glasses lens specification.
public struct VisionPrism: Sendable {
    public let amount: Double? // prism diopters (polar coordinates)
    public let angle: Double? // degrees (polar coordinates)
    public let verticalAmount: Double? // prism diopters (rectangular coordinates)
    public let horizontalAmount: Double? // prism diopters (rectangular coordinates)
    public let verticalBase: String? // "up"/"down"
    public let horizontalBase: String? // "in"/"out"
    public let eye: String // "left"/"right"

    public init(
        amount: Double? = nil,
        angle: Double? = nil,
        verticalAmount: Double? = nil,
        horizontalAmount: Double? = nil,
        verticalBase: String? = nil,
        horizontalBase: String? = nil,
        eye: String
    ) {
        self.amount = amount
        self.angle = angle
        self.verticalAmount = verticalAmount
        self.horizontalAmount = horizontalAmount
        self.verticalBase = verticalBase
        self.horizontalBase = horizontalBase
        self.eye = eye
    }
}

public struct GlassesPrescription: Sendable {

    public struct EyeSpecification: Sendable {
        public let lens: LensSpecification
        public let vertexDistance: Double? // mm
        public let prism: VisionPrism?
        public let farPupillaryDistance: Double? // mm
        public let nearPupillaryDistance: Double? // mm

        public init(lens: LensSpecification, vertexDistance: Double? = nil, prism: VisionPrism? = nil, farPupillaryDistance: Double? = nil, nearPupillaryDistance: Double? = nil) {
            self.lens = lens
            self.vertexDistance = vertexDistance
            self.prism = prism
            self.farPupillaryDistance = farPupillaryDistance
            self.nearPupillaryDistance = nearPupillaryDistance
        }
    }

    public struct Item: Sendable {
        public let rightEye: EyeSpecification?
        public let leftEye: EyeSpecification?
        public let dateIssued: Date
        public let expirationDate: Date?

        public init(rightEye: EyeSpecification? = nil, leftEye: EyeSpecification? = nil, dateIssued: Date, expirationDate: Date? = nil) {
            self.rightEye = rightEye
            self.leftEye = leftEye
            self.dateIssued = dateIssued
            self.expirationDate = expirationDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.dateIssued < $1.dateIssued })
    }
}

public struct ContactsPrescription: Sendable {

    public struct EyeSpecification: Sendable {
        public let lens: LensSpecification
        public let baseCurve: Double? // mm
        public let diameter: Double? // mm

        public init(lens: LensSpecification, baseCurve: Double? = nil, diameter: Double? = nil) {
            self.lens = lens
            self.baseCurve = baseCurve
            self.diameter = diameter
        }
    }

    public struct Item: Sendable {
        public let rightEye: EyeSpecification?
        public let leftEye: EyeSpecification?
        public let brand: String
        public let dateIssued: Date
        public let expirationDate: Date?

        public init(rightEye: EyeSpecification? = nil, leftEye: EyeSpecification? = nil, brand: String, dateIssued: Date, expirationDate: Date? = nil) {
            self.rightEye = rightEye
            self.leftEye = leftEye
            self.brand = brand
            self.dateIssued = dateIssued
            self.expirationDate = expirationDate
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public var mostRecent: Item? {
        items.max(by: { $0.dateIssued < $1.dateIssued })
    }
}
