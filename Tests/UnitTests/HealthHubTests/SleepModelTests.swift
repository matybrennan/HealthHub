import Testing
import Foundation
@testable import HealthHub

@Suite("Sleep Model Suite")
struct SleepModelTests {

    // MARK: - Sleep.Info.Style.isAsleep

    @Test("In Bed is not asleep")
    func inBedIsNotAsleep() {
        #expect(Sleep.Info.Style.inBed.isAsleep == false)
    }

    @Test("Awake is not asleep")
    func awakeIsNotAsleep() {
        #expect(Sleep.Info.Style.awake.isAsleep == false)
    }

    @Test("Asleep Unspecified is asleep")
    func asleepUnspecifiedIsAsleep() {
        #expect(Sleep.Info.Style.asleepUnspecified.isAsleep == true)
    }

    @Test("Asleep Core is asleep")
    func asleepCoreIsAsleep() {
        #expect(Sleep.Info.Style.asleepCore.isAsleep == true)
    }

    @Test("Asleep Deep is asleep")
    func asleepDeepIsAsleep() {
        #expect(Sleep.Info.Style.asleepDeep.isAsleep == true)
    }

    @Test("Asleep REM is asleep")
    func asleepREMIsAsleep() {
        #expect(Sleep.Info.Style.asleepREM.isAsleep == true)
    }

    // MARK: - Sleep.Info.Style.displayName

    @Test("In Bed display name")
    func inBedDisplayName() {
        #expect(Sleep.Info.Style.inBed.displayName == "In Bed")
    }

    @Test("Awake display name")
    func awakeDisplayName() {
        #expect(Sleep.Info.Style.awake.displayName == "Awake")
    }

    @Test("Core sleep display name")
    func coreSleepDisplayName() {
        #expect(Sleep.Info.Style.asleepCore.displayName == "Core Sleep")
    }

    @Test("Deep sleep display name")
    func deepSleepDisplayName() {
        #expect(Sleep.Info.Style.asleepDeep.displayName == "Deep Sleep")
    }

    @Test("REM sleep display name")
    func remSleepDisplayName() {
        #expect(Sleep.Info.Style.asleepREM.displayName == "REM Sleep")
    }

    @Test("Sleep apnea events count total events")
    func sleepApneaEventTotalEvents() {
        let start = Date()
        let end = start.addingTimeInterval(600)
        let model = SleepApneaEvent(items: [
            SleepApneaEvent.Item(startDate: start, endDate: end),
            SleepApneaEvent.Item(startDate: end, endDate: end.addingTimeInterval(300))
        ])

        #expect(model.totalEvents == 2)
        #expect(model.mostRecent?.endDate == end.addingTimeInterval(300))
    }

    @Test("Sleeping breathing disturbances aggregate counts")
    func sleepingBreathingDisturbancesAggregates() {
        let start = Date()
        let items = [
            SleepingBreathingDisturbances.Item(count: 2, startDate: start, endDate: start.addingTimeInterval(60)),
            SleepingBreathingDisturbances.Item(count: 4, startDate: start.addingTimeInterval(120), endDate: start.addingTimeInterval(180))
        ]
        let model = SleepingBreathingDisturbances(items: items)

        #expect(model.averageCount == 3.0)
        #expect(model.totalCount == 6.0)
    }
}
