import Testing
import Foundation
@testable import HealthHub

@Suite("Heartbeat Series Model Suite")
struct HeartbeatSeriesModelTests {

    @Test("Heartbeat series item duration computes correctly")
    func itemDuration() {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(45)
        let item = HeartbeatSeries.Item(startDate: startDate, endDate: endDate)

        #expect(item.duration == 45)
    }

    @Test("Most recent heartbeat series is selected by latest end date")
    func mostRecent() {
        let now = Date()
        let model = HeartbeatSeries(items: [
            HeartbeatSeries.Item(startDate: now, endDate: now),
            HeartbeatSeries.Item(startDate: now, endDate: now.addingTimeInterval(120))
        ])

        #expect(model.mostRecent?.duration == 120)
    }

    @Test("Total heartbeat series duration sums all samples")
    func totalDuration() {
        let now = Date()
        let model = HeartbeatSeries(items: [
            HeartbeatSeries.Item(startDate: now, endDate: now.addingTimeInterval(10)),
            HeartbeatSeries.Item(startDate: now, endDate: now.addingTimeInterval(20))
        ])

        #expect(model.totalDuration == 30)
    }

    @Test("Heartbeat series record exposes count, gaps, and end date")
    func recordComputedProperties() {
        let startDate = Date()
        let record = HeartbeatSeries.Record(startDate: startDate, heartbeats: [
            HeartbeatSeries.Heartbeat(timeSinceSeriesStart: 1.5, precededByGap: false),
            HeartbeatSeries.Heartbeat(timeSinceSeriesStart: 3.5, precededByGap: true)
        ])

        #expect(record.totalHeartbeats == 2)
        #expect(record.containsGaps == true)
        #expect(record.endDate == startDate.addingTimeInterval(3.5))
    }
}
