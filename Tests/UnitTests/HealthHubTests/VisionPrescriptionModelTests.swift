import Testing
import Foundation
@testable import HealthHub

@Suite("Vision Prescription Model Suite")
struct VisionPrescriptionModelTests {

    @Test("Glasses prescription mostRecent returns the latest dateIssued item")
    func glassesMostRecent() {
        let older = GlassesPrescription.Item(
            rightEye: .init(lens: .init(sphere: -1.0)),
            leftEye: .init(lens: .init(sphere: -1.25)),
            dateIssued: Date(timeIntervalSince1970: 0),
            expirationDate: nil
        )
        let newer = GlassesPrescription.Item(
            rightEye: .init(lens: .init(sphere: -1.5)),
            leftEye: .init(lens: .init(sphere: -1.75)),
            dateIssued: Date(timeIntervalSince1970: 1_000_000),
            expirationDate: nil
        )
        let model = GlassesPrescription(items: [older, newer])

        #expect(model.mostRecent?.dateIssued == newer.dateIssued)
        #expect(model.mostRecent?.rightEye?.lens.sphere == -1.5)
    }

    @Test("Glasses prescription mostRecent is nil for an empty item list")
    func glassesMostRecentEmpty() {
        let model = GlassesPrescription(items: [])
        #expect(model.mostRecent == nil)
    }

    @Test("Contacts prescription mostRecent returns the latest dateIssued item")
    func contactsMostRecent() {
        let older = ContactsPrescription.Item(
            rightEye: .init(lens: .init(sphere: -2.0), baseCurve: 8.6, diameter: 14.2),
            leftEye: nil,
            brand: "Acuvue",
            dateIssued: Date(timeIntervalSince1970: 0),
            expirationDate: nil
        )
        let newer = ContactsPrescription.Item(
            rightEye: .init(lens: .init(sphere: -2.25), baseCurve: 8.6, diameter: 14.2),
            leftEye: nil,
            brand: "Biofinity",
            dateIssued: Date(timeIntervalSince1970: 2_000_000),
            expirationDate: nil
        )
        let model = ContactsPrescription(items: [older, newer])

        #expect(model.mostRecent?.brand == "Biofinity")
    }

    @Test("Vision prism supports both polar and rectangular coordinate systems")
    func visionPrismCoordinateSystems() {
        let polar = VisionPrism(amount: 1.5, angle: 90, eye: "right")
        let rectangular = VisionPrism(verticalAmount: 0.5, horizontalAmount: 1.0, verticalBase: "up", horizontalBase: "in", eye: "left")

        #expect(polar.amount == 1.5)
        #expect(polar.verticalAmount == nil)
        #expect(rectangular.verticalAmount == 0.5)
        #expect(rectangular.amount == nil)
    }

    @Test("Lens specification defaults optional fields to nil")
    func lensSpecificationDefaults() {
        let lens = LensSpecification(sphere: -0.75)
        #expect(lens.cylinder == nil)
        #expect(lens.axis == nil)
        #expect(lens.addPower == nil)
    }
}
