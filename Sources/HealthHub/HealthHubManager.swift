//
//  HealthHubManager.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/6/18.
//

import Foundation
import Combine

public final class HealthHubManager {

    private let configurationService: ConfigurationServiceProtocol
    private let activityManagerService: ActivityManagerProtocol
    private let heartManagerService: HeartManagerProtocol
    private let characteristicsService: CharacteristicServiceProtocol
    private let mobilityService: MobilityServiceProtocol
    private let nutritionService: NutritionServiceProtocol
    private let sleepService: SleepServiceProtocol
    private let bodyMeasurementsService: BodyMeasurementsServiceProtocol
    private let mindfulService: MentalWellbeingServiceProtocol
    private let cycleTrackingService: CycleTrackingProtocol
    private let symptomsService: SymptomsServiceProtocol
    private let respiratoryService: RespiratoryServiceProtocol
    private let vitalsService: VitalsServiceProtocol
    private let otherDataService: OtherDataServiceProtocol
    private let hearingService: HearingServiceProtocol
    private let clinicalRecordsService: ClinicalRecordsServiceProtocol
    private let cdaDocumentsService: CDADocumentsServiceProtocol
    private let electrocardiogramService: ElectrocardiogramServiceProtocol
    private let heartbeatSeriesService: HeartbeatSeriesServiceProtocol
    private let verifiableClinicalRecordsService: VerifiableClinicalRecordsServiceProtocol
    private let attachmentsService: AttachmentsServiceProtocol
    private let medicationsService: MedicationsServiceProtocol
    private let visionPrescriptionsService: VisionPrescriptionsServiceProtocol

    public init(
        configuration: ConfigurationServiceProtocol,
        activityManager: ActivityManagerProtocol,
        heartManager: HeartManagerProtocol,
        characteristics: CharacteristicServiceProtocol,
        mobility: MobilityServiceProtocol,
        nutrition: NutritionServiceProtocol,
        sleep: SleepServiceProtocol,
        bodyMeasurements: BodyMeasurementsServiceProtocol,
        mindful: MentalWellbeingServiceProtocol,
        cycleTracking: CycleTrackingProtocol,
        symptoms: SymptomsServiceProtocol,
        respiratory: RespiratoryServiceProtocol,
        vitals: VitalsServiceProtocol,
        otherData: OtherDataServiceProtocol,
        hearing: HearingServiceProtocol,
        clinicalRecords: ClinicalRecordsServiceProtocol,
        cdaDocuments: CDADocumentsServiceProtocol,
        electrocardiogram: ElectrocardiogramServiceProtocol,
        heartbeatSeries: HeartbeatSeriesServiceProtocol,
        verifiableClinicalRecords: VerifiableClinicalRecordsServiceProtocol,
        attachments: AttachmentsServiceProtocol,
        medications: MedicationsServiceProtocol,
        visionPrescriptions: VisionPrescriptionsServiceProtocol
    ) {
        self.configurationService = configuration
        self.activityManagerService = activityManager
        self.heartManagerService = heartManager
        self.characteristicsService = characteristics
        self.mobilityService = mobility
        self.nutritionService = nutrition
        self.sleepService = sleep
        self.bodyMeasurementsService = bodyMeasurements
        self.mindfulService = mindful
        self.cycleTrackingService = cycleTracking
        self.symptomsService = symptoms
        self.respiratoryService = respiratory
        self.vitalsService = vitals
        self.otherDataService = otherData
        self.hearingService = hearing
        self.clinicalRecordsService = clinicalRecords
        self.cdaDocumentsService = cdaDocuments
        self.electrocardiogramService = electrocardiogram
        self.heartbeatSeriesService = heartbeatSeries
        self.verifiableClinicalRecordsService = verifiableClinicalRecords
        self.attachmentsService = attachments
        self.medicationsService = medications
        self.visionPrescriptionsService = visionPrescriptions
    }

    public convenience init() {
        self.init(
            configuration: ConfigurationService(healthStore: HealthStoreProvider.shared),
            activityManager: ActivityManager(),
            heartManager: HeartManager(),
            characteristics: CharacteristicService(),
            mobility: MobilityService(),
            nutrition: NutritionService(),
            sleep: SleepService(),
            bodyMeasurements: BodyMeasurementsService(),
            mindful: MentalWellbeingService(),
            cycleTracking: CycleTracking(),
            symptoms: SymptomsService(),
            respiratory: RespiratoryService(),
            vitals: VitalsService(),
            otherData: OtherDataService(),
            hearing: HearingService(),
            clinicalRecords: ClinicalRecordsService(),
            cdaDocuments: CDADocumentsService(),
            electrocardiogram: ElectrocardiogramService(),
            heartbeatSeries: HeartbeatSeriesService(),
            verifiableClinicalRecords: VerifiableClinicalRecordsService(),
            attachments: AttachmentsService(),
            medications: MedicationsService(),
            visionPrescriptions: VisionPrescriptionsService()
        )
    }
}


extension HealthHubManager: HealthHubManagerProtocol {
    
    public var configuration: ConfigurationServiceProtocol { configurationService }
    public var activityManager: ActivityManagerProtocol { activityManagerService }
    public var heartManager: HeartManagerProtocol { heartManagerService }
    public var characteristics: CharacteristicServiceProtocol { characteristicsService }
    public var mobility: MobilityServiceProtocol { mobilityService }
    public var nutrition: NutritionServiceProtocol { nutritionService }
    public var sleep: SleepServiceProtocol { sleepService }
    public var bodyMeasurements: BodyMeasurementsServiceProtocol { bodyMeasurementsService }
    public var mindful: MentalWellbeingServiceProtocol { mindfulService }
    public var cycleTracking: CycleTrackingProtocol { cycleTrackingService }
    public var symptoms: SymptomsServiceProtocol { symptomsService }
    public var respiratory: RespiratoryServiceProtocol { respiratoryService }
    public var vitals: VitalsServiceProtocol { vitalsService }
    public var otherData: OtherDataServiceProtocol { otherDataService }
    public var hearing: HearingServiceProtocol { hearingService }
    public var clinicalRecords: ClinicalRecordsServiceProtocol { clinicalRecordsService }
    public var cdaDocuments: CDADocumentsServiceProtocol { cdaDocumentsService }
    public var electrocardiogram: ElectrocardiogramServiceProtocol { electrocardiogramService }
    public var heartbeatSeries: HeartbeatSeriesServiceProtocol { heartbeatSeriesService }
    public var verifiableClinicalRecords: VerifiableClinicalRecordsServiceProtocol { verifiableClinicalRecordsService }
    public var attachments: AttachmentsServiceProtocol { attachmentsService }
    public var medications: MedicationsServiceProtocol { medicationsService }
    public var visionPrescriptions: VisionPrescriptionsServiceProtocol { visionPrescriptionsService }
}
