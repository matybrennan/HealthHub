import Testing
@testable import HealthHub

@Suite("HeartRate Model Suite")
struct HeartRateModelTests {

    // MARK: - Empty state

    @Test("Empty items produce zero total and average")
    func emptyItems() {
        let heartRate = HeartRate(items: [])
        #expect(heartRate.total == 0.0)
        #expect(heartRate.average == 0.0)
        #expect(heartRate.count == 0)
        #expect(heartRate.overallMax == nil)
        #expect(heartRate.overallMin == nil)
        #expect(heartRate.first == nil)
    }

    // MARK: - Computed properties

    @Test("Total sums all average BPMs")
    func total() {
        let items = [
            HeartRate.Item(max: 100, min: 60, average: 75),
            HeartRate.Item(max: 110, min: 65, average: 85),
            HeartRate.Item(max: 120, min: 70, average: 95)
        ]
        let heartRate = HeartRate(items: items)
        #expect(heartRate.total == 255.0)
    }

    @Test("Average divides total by item count")
    func average() {
        let items = [
            HeartRate.Item(max: 100, min: 60, average: 60),
            HeartRate.Item(max: 100, min: 60, average: 90)
        ]
        let heartRate = HeartRate(items: items)
        #expect(heartRate.average == 75.0)
    }

    @Test("overallMax returns highest max BPM")
    func overallMax() {
        let items = [
            HeartRate.Item(max: 95, min: 60, average: 75),
            HeartRate.Item(max: 130, min: 65, average: 90),
            HeartRate.Item(max: 110, min: 70, average: 85)
        ]
        let heartRate = HeartRate(items: items)
        #expect(heartRate.overallMax == 130.0)
    }

    @Test("overallMin returns lowest min BPM")
    func overallMin() {
        let items = [
            HeartRate.Item(max: 95, min: 60, average: 75),
            HeartRate.Item(max: 130, min: 45, average: 90),
            HeartRate.Item(max: 110, min: 70, average: 85)
        ]
        let heartRate = HeartRate(items: items)
        #expect(heartRate.overallMin == 45.0)
    }

    @Test("first returns the first item")
    func firstItem() {
        let items = [
            HeartRate.Item(max: 100, min: 60, average: 72),
            HeartRate.Item(max: 110, min: 65, average: 85)
        ]
        let heartRate = HeartRate(items: items)
        #expect(heartRate.first?.average == 72.0)
    }

    @Test("Item range spans from min to max")
    func itemRange() {
        let item = HeartRate.Item(max: 120, min: 55, average: 80)
        #expect(item.range == 55...120)
    }
}

