import Foundation

public extension TMDB {
    struct AggregateCredits: Codable, Identifiable, Sendable {
        public let id: Int
        public let cast: [AggregateCastMember]
        public let crew: [AggregateCrewMember]

        public init(id: Int, cast: [AggregateCastMember], crew: [AggregateCrewMember]) {
            self.id = id
            self.cast = cast
            self.crew = crew
        }
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

        public init(
            isAdult: Bool,
            gender: Int?,
            id: Int,
            knownForDepartment: String?,
            name: String,
            originalName: String,
            popularity: Double,
            profilePath: URL?,
            roles: [Role],
            totalEpisodeCount: Int,
            order: Int,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.gender = gender
            self.id = id
            self.knownForDepartment = knownForDepartment
            self.name = name
            self.originalName = originalName
            self.popularity = popularity
            self.profilePath = profilePath
            self.roles = roles
            self.totalEpisodeCount = totalEpisodeCount
            self.order = order
        }

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

            public init(creditID: String, character: String, episodeCount: Int) {
                self.creditID = creditID
                self.character = character
                self.episodeCount = episodeCount
            }

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

        public init(
            isAdult: Bool,
            gender: Int?,
            id: Int,
            knownForDepartment: String?,
            name: String,
            originalName: String,
            popularity: Double,
            profilePath: URL?,
            department: String,
            jobs: [Job],
            totalEpisodeCount: Int,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.gender = gender
            self.id = id
            self.knownForDepartment = knownForDepartment
            self.name = name
            self.originalName = originalName
            self.popularity = popularity
            self.profilePath = profilePath
            self.department = department
            self.jobs = jobs
            self.totalEpisodeCount = totalEpisodeCount
        }

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

            public init(creditID: String, job: String, episodeCount: Int) {
                self.creditID = creditID
                self.job = job
                self.episodeCount = episodeCount
            }

            enum CodingKeys: String, CodingKey {
                case creditID = "creditId"
                case job
                case episodeCount
            }
        }
    }
}
