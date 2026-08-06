import Testing
@testable import HealthHub

@Suite("MobilityType Enum Suite")
struct MobilityTypeTests {

    @Test("All cases have non-empty display names")
    func allDisplayNamesNonEmpty() {
        for type in MobilityType.allCases {
            #expect(!type.displayName.isEmpty, "Empty displayName for \(type)")
        }
    }

    @Test("All cases have non-empty units")
    func allUnitsNonEmpty() {
        for type in MobilityType.allCases {
            #expect(!type.unit.isEmpty, "Empty unit for \(type)")
        }
    }

    @Test("Walking asymmetry is not saveable")
    func walkingAsymmetryNotSaveable() {
        #expect(MobilityType.walkingAsymmetry.isSaveable == false)
    }

    @Test("Walking steadiness is not saveable")
    func walkingSteadinessNotSaveable() {
        #expect(MobilityType.walkingSteadiness.isSaveable == false)
    }

    @Test("Walking steadiness notifications are not saveable")
    func walkingSteadinessEventNotSaveable() {
        #expect(MobilityType.walkingSteadinessEvent.isSaveable == false)
    }

    @Test("Cardio fitness is saveable")
    func cardioFitnessIsSaveable() {
        #expect(MobilityType.cardioFitness.isSaveable == true)
    }

    @Test("Six minute walk is saveable")
    func sixMinuteWalkIsSaveable() {
        #expect(MobilityType.sixMinuteWalk.isSaveable == true)
    }

    @Test("Walking speed unit is km/hr")
    func walkingSpeedUnit() {
        #expect(MobilityType.walkingSpeed.unit == "km/hr")
    }

    @Test("Ground contact time unit is ms")
    func groundContactTimeUnit() {
        #expect(MobilityType.groundContactTime.unit == "ms")
    }

    @Test("Walking steadiness notifications unit is events")
    func walkingSteadinessEventUnit() {
        #expect(MobilityType.walkingSteadinessEvent.unit == "events")
    }
}
