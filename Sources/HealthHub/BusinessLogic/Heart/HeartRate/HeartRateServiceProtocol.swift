import Foundation

public protocol HeartRateServiceProtocol: AnyObject {
    var current: HeartRate.Item? { get }
    var today: HeartRate { get }
    var thisWeek: HeartRate { get }
    var thisMonth: HeartRate { get }
    var allTime: HeartRate { get }
    var betweenDates: HeartRate { get }

    func heartRate(fromHeartRateType type: HeartRateType) async throws
    func reset(type: HeartRateType)
}
