import Testing
import Foundation
@testable import HealthHub

@Suite("Symptom Model Suite")
struct SymptomModelTests {

    // MARK: - GenericSymptomModel.Item.Style.isPresent

    @Test("Unspecified style is present (recorded but unspecified)")
    func unspecifiedIsPresent() {
        #expect(GenericSymptomModel.Item.Style.unspecified.isPresent == true)
    }

    @Test("Not present style is not present")
    func notPresentIsNotPresent() {
        #expect(GenericSymptomModel.Item.Style.notPresent.isPresent == false)
    }

    @Test("Mild style is present")
    func mildIsPresent() {
        #expect(GenericSymptomModel.Item.Style.mild.isPresent == true)
    }

    @Test("Moderate style is present")
    func moderateIsPresent() {
        #expect(GenericSymptomModel.Item.Style.moderate.isPresent == true)
    }

    @Test("Severe style is present")
    func severeIsPresent() {
        #expect(GenericSymptomModel.Item.Style.severe.isPresent == true)
    }

    // MARK: - GenericSymptomModel.Item.Style.name

    @Test("All style names are non-empty")
    func styleNamesNonEmpty() {
        let styles: [GenericSymptomModel.Item.Style] = [.unspecified, .notPresent, .mild, .moderate, .severe]
        for style in styles {
            #expect(!style.name.isEmpty)
        }
    }

    @Test("Mild style name is 'Mild'")
    func mildName() {
        #expect(GenericSymptomModel.Item.Style.mild.name == "Mild")
    }

    @Test("Severe style name is 'Severe'")
    func severeName() {
        #expect(GenericSymptomModel.Item.Style.severe.name == "Severe")
    }
}
