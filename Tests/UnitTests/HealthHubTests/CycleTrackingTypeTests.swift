import Testing
@testable import HealthHub

@Suite("CycleTrackingType Enum Suite")
struct CycleTrackingTypeTests {

    @Test("All cases have non-empty display names")
    func allDisplayNamesNonEmpty() {
        for type in CycleTrackingType.allCases {
            #expect(!type.displayName.isEmpty, "Empty displayName for \(type)")
        }
    }

    @Test("Symptom types have symptoms category")
    func symptomsCategory() {
        let types: [CycleTrackingType] = [.abdominalCramps, .bloating, .breastPain, .moodChanges, .vaginalDryness]
        for type in types {
            #expect(type.category == .symptoms, "\(type) should be symptoms")
        }
    }

    @Test("Tracking types have tracking category")
    func trackingCategory() {
        let types: [CycleTrackingType] = [.cervicalMucusQuality, .contraceptive, .lactation, .menstruation, .ovulation, .pregnancy, .sexualActivity, .spotting]
        for type in types {
            #expect(type.category == .tracking, "\(type) should be tracking")
        }
    }

    @Test("Notification types have notifications category")
    func notificationsCategory() {
        let types: [CycleTrackingType] = [.infrequentMenstrualCycles, .irregularMenstrualCycles, .persistentIntermenstrualBleeding, .prolongedMenstrualPeriods]
        for type in types {
            #expect(type.category == .notifications, "\(type) should be notifications")
        }
    }

    @Test("Cycle notification types are not saveable")
    func notificationTypesNotSaveable() {
        let notSaveable: [CycleTrackingType] = [.infrequentMenstrualCycles, .irregularMenstrualCycles, .persistentIntermenstrualBleeding, .prolongedMenstrualPeriods]
        for type in notSaveable {
            #expect(type.isSaveable == false, "\(type) should not be saveable")
        }
    }

    @Test("Tracking types are saveable")
    func trackingTypesAreSaveable() {
        let saveable: [CycleTrackingType] = [.cervicalMucusQuality, .contraceptive, .lactation, .menstruation, .ovulation, .pregnancy, .sexualActivity]
        for type in saveable {
            #expect(type.isSaveable == true, "\(type) should be saveable")
        }
    }

    @Test("Menstruation display name")
    func menstruationDisplayName() {
        #expect(CycleTrackingType.menstruation.displayName == "Menstruation")
    }
}
