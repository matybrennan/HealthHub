import Testing
import Foundation
import HealthKit
@testable import HealthHub

@Suite("HealthHubManager Suite")
struct HealthHubManagerTests {

    let mockConfig: MockConfigurationService
    let mockActivity: MockActivityManager
    let mockHeart: MockHeartManager
    let mockCharacteristics: MockCharacteristicService
    let mockMobility: MockMobilityService
    let mockNutrition: MockNutritionService
    let mockSleep: MockSleepService
    let mockBody: MockBodyMeasurementsService
    let mockMindful: MockMentalWellbeingService
    let mockCycleTracking: MockCycleTracking
    let mockSymptoms: MockSymptomsService
    let mockRespiratory: MockRespiratoryService
    let mockVitals: MockVitalsService
    let mockOtherData: MockOtherDataService
    let mockHearing: MockHearingService
    let mockClinicalRecords: MockClinicalRecordsService
    let mockCDADocuments: MockCDADocumentsService
    let mockElectrocardiogram: MockElectrocardiogramService
    let mockHeartbeatSeries: MockHeartbeatSeriesService
    let mockVerifiableClinicalRecords: MockVerifiableClinicalRecordsService
    let mockAttachments: MockAttachmentsService
    let mockMedications: MockMedicationsService
    let mockVisionPrescriptions: MockVisionPrescriptionsService
    let sut: HealthHubManager

    init() {
        mockConfig = MockConfigurationService()
        mockActivity = MockActivityManager()
        mockHeart = MockHeartManager()
        mockCharacteristics = MockCharacteristicService()
        mockMobility = MockMobilityService()
        mockNutrition = MockNutritionService()
        mockSleep = MockSleepService()
        mockBody = MockBodyMeasurementsService()
        mockMindful = MockMentalWellbeingService()
        mockCycleTracking = MockCycleTracking()
        mockSymptoms = MockSymptomsService()
        mockRespiratory = MockRespiratoryService()
        mockVitals = MockVitalsService()
        mockOtherData = MockOtherDataService()
        mockHearing = MockHearingService()
        mockClinicalRecords = MockClinicalRecordsService()
        mockCDADocuments = MockCDADocumentsService()
        mockElectrocardiogram = MockElectrocardiogramService()
        mockHeartbeatSeries = MockHeartbeatSeriesService()
        mockVerifiableClinicalRecords = MockVerifiableClinicalRecordsService()
        mockAttachments = MockAttachmentsService()
        mockMedications = MockMedicationsService()
        mockVisionPrescriptions = MockVisionPrescriptionsService()
        sut = HealthHubManager(
            configuration: mockConfig,
            activityManager: mockActivity,
            heartManager: mockHeart,
            characteristics: mockCharacteristics,
            mobility: mockMobility,
            nutrition: mockNutrition,
            sleep: mockSleep,
            bodyMeasurements: mockBody,
            mindful: mockMindful,
            cycleTracking: mockCycleTracking,
            symptoms: mockSymptoms,
            respiratory: mockRespiratory,
            vitals: mockVitals,
            otherData: mockOtherData,
            hearing: mockHearing,
            clinicalRecords: mockClinicalRecords,
            cdaDocuments: mockCDADocuments,
            electrocardiogram: mockElectrocardiogram,
            heartbeatSeries: mockHeartbeatSeries,
            verifiableClinicalRecords: mockVerifiableClinicalRecords,
            attachments: mockAttachments,
            medications: mockMedications,
            visionPrescriptions: mockVisionPrescriptions
        )
    }

    // MARK: - Configuration

    @Test("Configuration request delegates through the facade")
    func configurationDelegates() async throws {
        try await sut.configuration.requestAuthorization(toShare: [], toRead: [])
        #expect(mockConfig.requestAuthorizationCallCount == 1)
        #expect(mockConfig.state == .hasRequestedHealthKitInfo(true))
    }

    // MARK: - Sleep

    @Test("Sleep fetch delegates through the facade")
    func sleepFetch() async throws {
        _ = try await sut.sleep.sleep()
        #expect(mockSleep.sleepCallCount == 1)
    }

    @Test("Sleep save delegates through the facade")
    func sleepSave() async throws {
        try await sut.sleep.save(model: Sleep(items: []), extra: nil)
        #expect(mockSleep.saveCallCount == 1)
    }

    // MARK: - Hearing

    @Test("Hearing audiogram delegates through the facade")
    func hearingAudiogram() async throws {
        _ = try await sut.hearing.audiogram()
        #expect(mockHearing.fetchCallCount == 1)
    }

    @Test("Hearing environmental audio delegates through the facade")
    func hearingEnvironmental() async throws {
        _ = try await sut.hearing.environmentalAudioExposure()
        #expect(mockHearing.fetchCallCount == 1)
    }

    // MARK: - Respiratory

    @Test("Respiratory blood oxygen delegates through the facade")
    func respiratoryBloodOxygen() async throws {
        _ = try await sut.respiratory.bloodOxygen(from: .allTime)
        #expect(mockRespiratory.fetchCallCount == 1)
    }

    @Test("Respiratory save delegates through the facade")
    func respiratorySave() async throws {
        try await sut.respiratory.saveRespiratoryRate(model: RespiratoryRate(items: []), extra: nil)
        #expect(mockRespiratory.saveCallCount == 1)
    }

    // MARK: - Vitals

    @Test("Vitals blood glucose delegates through the facade")
    func vitalsBloodGlucose() async throws {
        _ = try await sut.vitals.bloodGlucose(from: .today)
        #expect(mockVitals.fetchCallCount == 1)
    }

    @Test("Vitals save delegates through the facade")
    func vitalsSave() async throws {
        try await sut.vitals.saveBloodGlucose(model: BloodGlucose(items: []), extra: nil)
        #expect(mockVitals.saveCallCount == 1)
    }

    // MARK: - Nutrition

    @Test("Nutrition fetch delegates through the facade")
    func nutritionFetch() async throws {
        _ = try await sut.nutrition.nutrition(type: .protein)
        #expect(mockNutrition.nutritionCallCount == 1)
        #expect(mockNutrition.lastNutritionType == .protein)
    }

    @Test("Food correlation fetch delegates through the facade")
    func foodFetch() async throws {
        _ = try await sut.nutrition.food()
        #expect(mockNutrition.foodCallCount == 1)
    }

    // MARK: - Body Measurements

    @Test("Body weight fetch delegates through the facade")
    func bodyWeightFetch() async throws {
        _ = try await sut.bodyMeasurements.weight(from: .thisWeek)
        #expect(mockBody.fetchCallCount == 1)
    }

    @Test("Body weight save delegates through the facade")
    func bodyWeightSave() async throws {
        try await sut.bodyMeasurements.saveWeight(model: BodyWeight(items: []), extra: nil)
        #expect(mockBody.saveCallCount == 1)
    }

    // MARK: - Mobility

    @Test("Mobility cardio fitness delegates through the facade")
    func mobilityCardioFitness() async throws {
        _ = try await sut.mobility.cardioFitness(from: .allTime)
        #expect(mockMobility.fetchCallCount == 1)
    }

    // MARK: - Mental Wellbeing

    @Test("Mindful activity delegates through the facade")
    func mindfulActivity() async throws {
        _ = try await sut.mindful.mindfulActivity()
        #expect(mockMindful.fetchCallCount == 1)
    }

    @Test("GAD-7 fetch delegates through the facade")
    func gad7Fetch() async throws {
        _ = try await sut.mindful.gad7()
        #expect(mockMindful.fetchCallCount == 1)
    }

    // MARK: - Symptoms

    @Test("Symptom fetch delegates through the facade")
    func symptomFetch() async throws {
        _ = try await sut.symptoms.symptom(type: .headache)
        #expect(mockSymptoms.symptomCallCount == 1)
        #expect(mockSymptoms.lastReceivedSymptomType == .headache)
    }

    // MARK: - Cycle Tracking

    @Test("Menstruation fetch delegates through the facade")
    func menstruationFetch() async throws {
        _ = try await sut.cycleTracking.menstruation()
        #expect(mockCycleTracking.fetchCallCount == 1)
    }

    // MARK: - Other Data

    @Test("Other data alcohol consumption delegates through the facade")
    func otherDataAlcohol() async throws {
        _ = try await sut.otherData.alcoholConsumption()
        #expect(mockOtherData.fetchCallCount == 1)
    }

    // MARK: - Heart Manager

    @Test("Heart cardio fitness delegates through the facade")
    func heartCardioFitness() async throws {
        _ = try await sut.heartManager.cardioFitness()
        #expect(mockHeart.fetchCallCount == 1)
    }

    @Test("Heart rate service is accessible through the facade")
    func heartRateService() {
        let mockHR = mockHeart.mockHeartRate
        #expect(mockHR.today.items.isEmpty)
    }

    // MARK: - Characteristics

    @Test("Characteristics returns injected biological sex")
    func biologicalSex() {
        mockCharacteristics.biologicalSex = .female
        #expect(sut.characteristics.biologicalSex == .female)
    }

    @Test("Characteristics returns injected blood type")
    func bloodType() {
        mockCharacteristics.bloodType = .oPositive
        #expect(sut.characteristics.bloodType == .oPositive)
    }

    // MARK: - Clinical Records

    @Test("Clinical records allergy record delegates through the facade")
    func clinicalRecordsAllergyRecord() async throws {
        _ = try await sut.clinicalRecords.allergyRecord()
        #expect(mockClinicalRecords.fetchCallCount == 1)
    }

    // MARK: - CDA Documents

    @Test("CDA documents delegates through the facade")
    func cdaDocuments() async throws {
        _ = try await sut.cdaDocuments.cdaDocuments()
        #expect(mockCDADocuments.fetchCallCount == 1)
    }

    // MARK: - Electrocardiogram

    @Test("Electrocardiogram delegates through the facade")
    func electrocardiogram() async throws {
        _ = try await sut.electrocardiogram.electrocardiogram()
        #expect(mockElectrocardiogram.electrocardiogramCallCount == 1)
    }

    // MARK: - Heartbeat Series

    @Test("Heartbeat series delegates through the facade")
    func heartbeatSeries() async throws {
        _ = try await sut.heartbeatSeries.heartbeatSeries()
        #expect(mockHeartbeatSeries.heartbeatSeriesCallCount == 1)
    }

    // MARK: - Verifiable Clinical Records

    @Test("Verifiable clinical records delegates through the facade")
    func verifiableClinicalRecords() async throws {
        _ = try await sut.verifiableClinicalRecords.verifiableClinicalRecords()
        #expect(mockVerifiableClinicalRecords.fetchCallCount == 1)
    }

    // MARK: - Attachments

    @Test("Attachments fetch delegates through the facade")
    func attachmentsFetch() async throws {
        _ = try await sut.attachments.attachments(for: HKQuantitySample(
            type: HKQuantityType(.stepCount),
            quantity: HKQuantity(unit: .count(), doubleValue: 1),
            start: Date(),
            end: Date()
        ))
        #expect(mockAttachments.fetchCallCount == 1)
    }

    // MARK: - Medications

    @Test("Medications delegates through the facade")
    func medications() async throws {
        _ = try await sut.medications.medications()
        #expect(mockMedications.fetchCallCount == 1)
    }

    // MARK: - Vision Prescriptions

    @Test("Vision prescriptions glasses delegates through the facade")
    func visionPrescriptionsGlasses() async throws {
        _ = try await sut.visionPrescriptions.glassesPrescriptions()
        #expect(mockVisionPrescriptions.fetchCallCount == 1)
    }
}
