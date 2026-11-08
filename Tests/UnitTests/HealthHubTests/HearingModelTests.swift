import Testing
import Foundation
@testable import HealthHub

@Suite("Hearing Model Suite")
struct HearingModelTests {

    // MARK: - HearingLossClassification

    @Test("PTA < 26 dBHL classifies as normal")
    func hearingLossNormal() {
        #expect(AudiogramEntry.HearingLossClassification(pta: 10) == .normal)
        #expect(AudiogramEntry.HearingLossClassification(pta: 25.9) == .normal)
    }

    @Test("PTA 26–40 dBHL classifies as mild")
    func hearingLossMild() {
        #expect(AudiogramEntry.HearingLossClassification(pta: 26) == .mild)
        #expect(AudiogramEntry.HearingLossClassification(pta: 40) == .mild)
    }

    @Test("PTA 41–55 dBHL classifies as moderate")
    func hearingLossModerate() {
        #expect(AudiogramEntry.HearingLossClassification(pta: 41) == .moderate)
        #expect(AudiogramEntry.HearingLossClassification(pta: 55) == .moderate)
    }

    @Test("PTA 56–70 dBHL classifies as moderately severe")
    func hearingLossModeratelySevere() {
        #expect(AudiogramEntry.HearingLossClassification(pta: 56) == .moderatelySevere)
        #expect(AudiogramEntry.HearingLossClassification(pta: 70) == .moderatelySevere)
    }

    @Test("PTA 71–90 dBHL classifies as severe")
    func hearingLossSevere() {
        #expect(AudiogramEntry.HearingLossClassification(pta: 71) == .severe)
        #expect(AudiogramEntry.HearingLossClassification(pta: 90) == .severe)
    }

    @Test("PTA >= 91 dBHL classifies as profound")
    func hearingLossProfound() {
        #expect(AudiogramEntry.HearingLossClassification(pta: 91) == .profound)
        #expect(AudiogramEntry.HearingLossClassification(pta: 120) == .profound)
    }

    // MARK: - EnvironmentalAudioExposureEvent

    @Test("Sound level <= 70 dB does not exceed WHO recommended level")
    func environmentalBelowThreshold() {
        let item = EnvironmentalAudioExposureEvent.Item(value: 65, startDate: Date(), endDate: Date())
        #expect(item.exceedsRecommendedLevel == false)
        #expect(item.exceedsDamageThreshold == false)
    }

    @Test("Sound level > 70 dB exceeds WHO recommended level")
    func environmentalAboveWHO() {
        let item = EnvironmentalAudioExposureEvent.Item(value: 75, startDate: Date(), endDate: Date())
        #expect(item.exceedsRecommendedLevel == true)
        #expect(item.exceedsDamageThreshold == false)
    }

    @Test("Sound level > 85 dB exceeds NIOSH damage threshold")
    func environmentalAboveNIOSH() {
        let item = EnvironmentalAudioExposureEvent.Item(value: 90, startDate: Date(), endDate: Date())
        #expect(item.exceedsRecommendedLevel == true)
        #expect(item.exceedsDamageThreshold == true)
    }

    @Test("Average level computes correctly")
    func environmentalAverageLevel() {
        let start = Date()
        let items = [
            EnvironmentalAudioExposureEvent.Item(value: 60, startDate: start, endDate: start),
            EnvironmentalAudioExposureEvent.Item(value: 80, startDate: start, endDate: start),
            EnvironmentalAudioExposureEvent.Item(value: 100, startDate: start, endDate: start)
        ]
        let event = EnvironmentalAudioExposureEvent(items: items)
        #expect(event.averageLevel == 80.0)
    }

    @Test("Average level is nil for empty items")
    func environmentalAverageLevelEmpty() {
        let event = EnvironmentalAudioExposureEvent(items: [])
        #expect(event.averageLevel == nil)
    }

    // MARK: - HeadphoneAudioExposureEvent

    @Test("Headphone level <= 85 dB does not exceed recommended level")
    func headphoneBelowThreshold() {
        let item = HeadphoneAudioExposureEvent.Item(value: 80, startDate: Date(), endDate: Date())
        #expect(item.exceedsRecommendedLevel == false)
    }

    @Test("Headphone level > 85 dB exceeds recommended level")
    func headphoneAboveThreshold() {
        let item = HeadphoneAudioExposureEvent.Item(value: 90, startDate: Date(), endDate: Date())
        #expect(item.exceedsRecommendedLevel == true)
    }

    @Test("Environmental audio exposure notifications count events")
    func environmentalAudioExposureNotificationTotalEvents() {
        let now = Date()
        let model = EnvironmentalAudioExposureNotification(items: [
            EnvironmentalAudioExposureNotification.Item(type: .momentaryLimit, startDate: now, endDate: now),
            EnvironmentalAudioExposureNotification.Item(type: .momentaryLimit, startDate: now, endDate: now.addingTimeInterval(10))
        ])

        #expect(model.totalEvents == 2)
        #expect(model.mostRecent?.type == .momentaryLimit)
    }

    @Test("Headphone audio exposure notifications use seven day limit label")
    func headphoneAudioExposureNotificationDisplayName() {
        #expect(HeadphoneAudioExposureNotification.EventType.sevenDayLimit.displayName == "Seven-Day Limit")
    }

    @Test("Environmental sound reduction average computes correctly")
    func environmentalSoundReductionAverage() {
        let start = Date()
        let model = EnvironmentalSoundReduction(items: [
            EnvironmentalSoundReduction.Item(value: 10, startDate: start, endDate: start),
            EnvironmentalSoundReduction.Item(value: 20, startDate: start, endDate: start)
        ])

        #expect(model.averageReduction == 15.0)
    }
}
