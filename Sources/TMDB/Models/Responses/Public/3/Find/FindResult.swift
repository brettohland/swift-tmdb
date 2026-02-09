import Foundation

public extension TMDB {
    struct FindResult: Codable, Sendable {
        public let movieResults: [Discover.DiscoverMovie]
        public let tvResults: [Discover.DiscoverTV]
        public let personResults: [FindPerson]
        public let tvEpisodeResults: [FindTVEpisode]
        public let tvSeasonResults: [FindTVSeason]
    }
}

// MARK: - Nested Types

public extension TMDB {
    struct FindPerson: Codable, Sendable {
        public let id: Int
        public let name: String
        @NilBoolean
        public var isAdult: Bool
        public let gender: Int?
        public let popularity: Double?
        public let profilePath: String?
        public let knownForDepartment: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case isAdult = "adult"
            case gender
            case popularity
            case profilePath
            case knownForDepartment
        }
    }

    struct FindTVEpisode: Codable, Sendable {
        public let id: Int
        public let name: String
        public let overview: String
        public let voteAverage: Double?
        public let voteCount: Int?
        @ISO8601YMD
        public var airDate: Date?
        public let episodeNumber: Int
        public let seasonNumber: Int
        public let showID: Int
        public let stillPath: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overview
            case voteAverage
            case voteCount
            case airDate
            case episodeNumber
            case seasonNumber
            case showID = "showId"
            case stillPath
        }
    }

    struct FindTVSeason: Codable, Sendable {
        public let id: Int
        public let name: String
        public let overview: String
        @ISO8601YMD
        public var airDate: Date?
        public let posterPath: String?
        public let seasonNumber: Int
        public let showID: Int

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overview
            case airDate
            case posterPath
            case seasonNumber
            case showID = "showId"
        }
    }
}
