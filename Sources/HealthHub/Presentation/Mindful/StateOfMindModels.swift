//
//  StateOfMindModels.swift
//  HealthHub
//
//  Created by Maty Brennan on 29/6/2026.
//

import Foundation
import HealthKit

// MARK: - State of Mind

public struct StateOfMindEntry: Sendable {

    public enum Kind: Int, Sendable {
        case momentaryEmotion = 1
        case dailyMood = 2

        public var displayName: String {
            switch self {
            case .momentaryEmotion: "Momentary Emotion"
            case .dailyMood: "Daily Mood"
            }
        }
    }

    public enum ValenceClassification: Int, Sendable {
        case veryUnpleasant = 1
        case unpleasant
        case slightlyUnpleasant
        case neutral
        case slightlyPleasant
        case pleasant
        case veryPleasant

        public var displayName: String {
            switch self {
            case .veryUnpleasant: "Very Unpleasant"
            case .unpleasant: "Unpleasant"
            case .slightlyUnpleasant: "Slightly Unpleasant"
            case .neutral: "Neutral"
            case .slightlyPleasant: "Slightly Pleasant"
            case .pleasant: "Pleasant"
            case .veryPleasant: "Very Pleasant"
            }
        }
    }

    public enum Label: Int, CaseIterable, Sendable {
        case amazed = 1
        case amused
        case angry
        case anxious
        case ashamed
        case brave
        case calm
        case content
        case disappointed
        case discouraged
        case disgusted
        case embarrassed
        case excited
        case frustrated
        case grateful
        case guilty
        case happy
        case hopeless
        case irritated
        case jealous
        case joyful
        case lonely
        case passionate
        case peaceful
        case proud
        case relieved
        case sad
        case scared
        case stressed
        case surprised
        case worried
        case annoyed
        case confident
        case drained
        case hopeful
        case indifferent
        case overwhelmed
        case satisfied

        public var displayName: String {
            switch self {
            case .amazed: "Amazed"
            case .amused: "Amused"
            case .angry: "Angry"
            case .anxious: "Anxious"
            case .ashamed: "Ashamed"
            case .brave: "Brave"
            case .calm: "Calm"
            case .content: "Content"
            case .disappointed: "Disappointed"
            case .discouraged: "Discouraged"
            case .disgusted: "Disgusted"
            case .embarrassed: "Embarrassed"
            case .excited: "Excited"
            case .frustrated: "Frustrated"
            case .grateful: "Grateful"
            case .guilty: "Guilty"
            case .happy: "Happy"
            case .hopeless: "Hopeless"
            case .irritated: "Irritated"
            case .jealous: "Jealous"
            case .joyful: "Joyful"
            case .lonely: "Lonely"
            case .passionate: "Passionate"
            case .peaceful: "Peaceful"
            case .proud: "Proud"
            case .relieved: "Relieved"
            case .sad: "Sad"
            case .scared: "Scared"
            case .stressed: "Stressed"
            case .surprised: "Surprised"
            case .worried: "Worried"
            case .annoyed: "Annoyed"
            case .confident: "Confident"
            case .drained: "Drained"
            case .hopeful: "Hopeful"
            case .indifferent: "Indifferent"
            case .overwhelmed: "Overwhelmed"
            case .satisfied: "Satisfied"
            }
        }
    }

    public enum Association: Int, CaseIterable, Sendable {
        case community = 1
        case currentEvents
        case dating
        case education
        case family
        case fitness
        case friends
        case health
        case hobbies
        case identity
        case money
        case partner
        case selfCare
        case spirituality
        case tasks
        case travel
        case work
        case weather

        public var displayName: String {
            switch self {
            case .community: "Community"
            case .currentEvents: "Current Events"
            case .dating: "Dating"
            case .education: "Education"
            case .family: "Family"
            case .fitness: "Fitness"
            case .friends: "Friends"
            case .health: "Health"
            case .hobbies: "Hobbies"
            case .identity: "Identity"
            case .money: "Money"
            case .partner: "Partner"
            case .selfCare: "Self-Care"
            case .spirituality: "Spirituality"
            case .tasks: "Tasks"
            case .travel: "Travel"
            case .work: "Work"
            case .weather: "Weather"
            }
        }
    }

    public struct Item: Sendable {
        public let kind: Kind
        /// Valence from -1 (very unpleasant) to +1 (very pleasant)
        public let valence: Double
        public let valenceClassification: ValenceClassification
        public let labels: [Label]
        public let associations: [Association]
        public let date: Date

        public init(kind: Kind, valence: Double, valenceClassification: ValenceClassification, labels: [Label], associations: [Association], date: Date) {
            self.kind = kind
            self.valence = valence
            self.valenceClassification = valenceClassification
            self.labels = labels
            self.associations = associations
            self.date = date
        }

        /// Whether the entry reflects a positive feeling
        public var isPositive: Bool { valence > 0 }

        /// Whether the entry reflects a negative feeling
        public var isNegative: Bool { valence < 0 }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent entry
    public var mostRecent: Item? { items.first }

    /// Average valence across all entries (-1 to +1)
    public var averageValence: Double? {
        guard !items.isEmpty else { return nil }
        return items.reduce(0) { $0 + $1.valence } / Double(items.count)
    }

    /// Entries filtered by kind
    public func entries(for kind: Kind) -> [Item] {
        items.filter { $0.kind == kind }
    }

    /// Momentary emotion entries only
    public var emotions: [Item] {
        entries(for: .momentaryEmotion)
    }

    /// Daily mood entries only
    public var moods: [Item] {
        entries(for: .dailyMood)
    }
}

// MARK: - GAD-7 (Anxiety Assessment)

public struct GAD7Assessment: Sendable {

    public enum Risk: Int, Sendable {
        case noneToMinimal = 1
        case mild
        case moderate
        case severe

        public var displayName: String {
            switch self {
            case .noneToMinimal: "None to Minimal"
            case .mild: "Mild"
            case .moderate: "Moderate"
            case .severe: "Severe"
            }
        }
    }

    public enum Answer: Int, Sendable {
        case notAtAll = 0
        case severalDays
        case moreThanHalfTheDays
        case nearlyEveryDay

        public var displayName: String {
            switch self {
            case .notAtAll: "Not at all"
            case .severalDays: "Several days"
            case .moreThanHalfTheDays: "More than half the days"
            case .nearlyEveryDay: "Nearly every day"
            }
        }

        public var score: Int { rawValue }
    }

    public struct Item: Sendable {
        public let score: Int
        public let risk: Risk
        public let answers: [Answer]
        public let date: Date

        public init(score: Int, risk: Risk, answers: [Answer], date: Date) {
            self.score = score
            self.risk = risk
            self.answers = answers
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent assessment
    public var mostRecent: Item? { items.first }

    /// Maximum possible score
    public static let maxScore = 21
}

// MARK: - PHQ-9 (Depression Assessment)

public struct PHQ9Assessment: Sendable {

    public enum Risk: Int, Sendable {
        case noneToMinimal = 1
        case mild
        case moderate
        case moderatelySevere
        case severe

        public var displayName: String {
            switch self {
            case .noneToMinimal: "None to Minimal"
            case .mild: "Mild"
            case .moderate: "Moderate"
            case .moderatelySevere: "Moderately Severe"
            case .severe: "Severe"
            }
        }
    }

    public enum Answer: Int, Sendable {
        case notAtAll = 0
        case severalDays
        case moreThanHalfTheDays
        case nearlyEveryDay
        case preferNotToAnswer

        public var displayName: String {
            switch self {
            case .notAtAll: "Not at all"
            case .severalDays: "Several days"
            case .moreThanHalfTheDays: "More than half the days"
            case .nearlyEveryDay: "Nearly every day"
            case .preferNotToAnswer: "Prefer not to answer"
            }
        }

        public var score: Int {
            switch self {
            case .preferNotToAnswer: 0
            default: rawValue
            }
        }
    }

    public struct Item: Sendable {
        public let score: Int
        public let risk: Risk
        public let answers: [Answer]
        public let date: Date

        public init(score: Int, risk: Risk, answers: [Answer], date: Date) {
            self.score = score
            self.risk = risk
            self.answers = answers
            self.date = date
        }
    }

    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    /// Most recent assessment
    public var mostRecent: Item? { items.first }

    /// Maximum possible score
    public static let maxScore = 27
}
