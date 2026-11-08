import Testing
@testable import HealthHub

@Suite("SymptomType Enum Suite")
struct SymptomTypeTests {

    @Test("All cases have non-empty display names")
    func allDisplayNamesNonEmpty() {
        for type in SymptomType.allCases {
            #expect(!type.displayName.isEmpty, "Empty displayName for \(type)")
        }
    }

    @Test("Gastrointestinal symptoms have correct category")
    func gastrointestinalCategory() {
        let types: [SymptomType] = [.abdominalCramps, .bloating, .constipation, .diarrhea, .heartBurn, .nausea, .vomiting]
        for type in types {
            #expect(type.category == .gastrointestinal, "\(type) should be gastrointestinal")
        }
    }

    @Test("Pain symptoms have correct category")
    func painCategory() {
        let types: [SymptomType] = [.headache, .lowerBackPain, .chestTightnessOrPain, .pelvicPain]
        for type in types {
            #expect(type.category == .pain, "\(type) should be pain")
        }
    }

    @Test("Respiratory symptoms have correct category")
    func respiratoryCategory() {
        let types: [SymptomType] = [.congestion, .coughing, .runnyNose, .shortnessOfBreath, .soreThroat, .wheezing]
        for type in types {
            #expect(type.category == .respiratory, "\(type) should be respiratory")
        }
    }

    @Test("Cardiovascular symptoms have correct category")
    func cardiovascularCategory() {
        let types: [SymptomType] = [.rapidPoundingOrFlutteringHeartbeat, .skippedHeartbeat]
        for type in types {
            #expect(type.category == .cardiovascular, "\(type) should be cardiovascular")
        }
    }

    @Test("Constitutional symptoms have correct category")
    func constitutionalCategory() {
        let types: [SymptomType] = [.chills, .fever, .hotFlushes, .nightSweats]
        for type in types {
            #expect(type.category == .constitutional, "\(type) should be constitutional")
        }
    }

    @Test("Neurological symptoms have correct category")
    func neurologicalCategory() {
        let types: [SymptomType] = [.dizziness, .fainting, .fatigue, .memoryLapse, .moodChanges, .sleepChanges]
        for type in types {
            #expect(type.category == .neurologicalAndMental, "\(type) should be neurologicalAndMental")
        }
    }

    @Test("Headache display name")
    func headacheDisplayName() {
        #expect(SymptomType.headache.displayName == "Headache")
    }

    @Test("Fever display name")
    func feverDisplayName() {
        #expect(SymptomType.fever.displayName == "Fever")
    }
}
