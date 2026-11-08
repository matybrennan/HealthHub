import Foundation
import HealthKit
@testable import HealthHub

final class MockCharacteristicService: CharacteristicServiceProtocol {

    var biologicalSex: BiologicalSex = .notSet
    var bloodType: BloodType = .notSet
    var dateOfBirth: DateComponents? = nil
    var skinType: FitzpatrickSkinType = .notSet
    var isWheelChairUser: WheelchairUse = .notSet
    var activityMoveMode: ActivityMoveMode = .notSet
}
