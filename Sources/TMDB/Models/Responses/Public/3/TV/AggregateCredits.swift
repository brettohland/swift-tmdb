import Foundation

public extension TMDB {
    struct AggregateCredits: Codable, Identifiable, Sendable {
        public let id: Int
        public let cast: [AggregateCastMember]
        public let crew: [AggregateCrewMember]
    }

    struct AggregateCastMember: Codable, Identifiable, Sendable {
        @NilBoolean
        public var isAdult: Bool
        public let gender: Int?
        public let id: Int
        public let knownForDepartment: String?
        public let name: String
        public let originalName: String
        public let popularity: Double
        public let profilePath: URL?
        public let roles: [Role]
        public let totalEpisodeCount: Int
        public let order: Int

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case gender
            case id
            case knownForDepartment
            case name
            case originalName
            case popularity
            case profilePath
            case roles
            case totalEpisodeCount
            case order
        }

        public struct Role: Codable, Sendable {
            public let creditID: String
            public let character: String
            public let episodeCount: Int

            enum CodingKeys: String, CodingKey {
                case creditID = "creditId"
                case character
                case episodeCount
            }
        }
    }

    struct AggregateCrewMember: Codable, Identifiable, Sendable {
        @NilBoolean
        public var isAdult: Bool
        public let gender: Int?
        public let id: Int
        public let knownForDepartment: String?
        public let name: String
        public let originalName: String
        public let popularity: Double
        public let profilePath: URL?
        public let department: String
        public let jobs: [Job]
        public let totalEpisodeCount: Int

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case gender
            case id
            case knownForDepartment
            case name
            case originalName
            case popularity
            case profilePath
            case department
            case jobs
            case totalEpisodeCount
        }

        public struct Job: Codable, Sendable {
            public let creditID: String
            public let job: String
            public let episodeCount: Int

            enum CodingKeys: String, CodingKey {
                case creditID = "creditId"
                case job
                case episodeCount
            }
        }
    }
}
