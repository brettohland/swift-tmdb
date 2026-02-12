import Foundation

public extension TMDB {
    struct TVSeries: Sendable {
        @NilBoolean
        public var isAdult: Bool
        public let backdropPath: URL?
        public let createdBy: [Creator]
        public let episodeRunTime: [Int]
        @ISO8601YMD
        public var firstAirDate: Date?
        public let genres: [Genre]
        @EmptyStringNullable
        public var homepage: URL?
        public let id: Int
        @NilBoolean
        public var isInProduction: Bool
        public let languages: [String]
        @ISO8601YMD
        public var lastAirDate: Date?
        public let lastEpisodeToAir: EpisodeOverview?
        public let name: String
        public let nextEpisodeToAir: EpisodeOverview?
        public let networks: [Network]
        public let numberOfEpisodes: Int
        public let numberOfSeasons: Int
        public let originCountry: [String]
        public let originalLanguage: String
        public let originalName: String
        public let overview: String
        public let popularity: Double
        public let posterPath: URL?
        public let productionCompanies: [ProductionCompany]
        @RegionArray
        public var productionCountries: [Locale.Region]
        public let seasons: [SeasonOverview]
        @LanguageArray
        public var spokenLanguages: [Locale.Language]
        public let status: String
        public let tagline: String
        public let type: String
        public let voteAverage: Double
        public let voteCount: Int
    }
}

// MARK: - Nested Types

public extension TMDB.TVSeries {
    struct Creator: Codable, Identifiable, Sendable {
        public let id: Int
        public let creditID: String
        public let name: String
        public let originalName: String
        public let gender: Int
        public let profilePath: URL?

        enum CodingKeys: String, CodingKey {
            case id
            case creditID = "creditId"
            case name
            case originalName
            case gender
            case profilePath
        }
    }

    struct Network: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let logoPath: URL?
        public let originCountry: String

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case logoPath
            case originCountry
        }
    }

    struct SeasonOverview: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: URL?
        @ISO8601YMD
        public var airDate: Date?
        public let episodeCount: Int
        public let seasonNumber: Int
        public let voteAverage: Double

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overview
            case posterPath
            case airDate
            case episodeCount
            case seasonNumber
            case voteAverage
        }
    }

    struct EpisodeOverview: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let overview: String
        public let episodeNumber: Int
        public let seasonNumber: Int
        @ISO8601YMD
        public var airDate: Date?
        public let stillPath: URL?
        public let voteAverage: Double
        public let voteCount: Int
        public let runtime: Int?
        public let productionCode: String
        public let showID: Int

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overview
            case episodeNumber
            case seasonNumber
            case airDate
            case stillPath
            case voteAverage
            case voteCount
            case runtime
            case productionCode
            case showID = "showId"
        }
    }
}

// MARK: - Codable

extension TMDB.TVSeries: Codable {
    enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
        case backdropPath
        case createdBy
        case episodeRunTime
        case firstAirDate
        case genres
        case homepage
        case id
        case isInProduction = "inProduction"
        case languages
        case lastAirDate
        case lastEpisodeToAir
        case name
        case nextEpisodeToAir
        case networks
        case numberOfEpisodes
        case numberOfSeasons
        case originCountry
        case originalLanguage
        case originalName
        case overview
        case popularity
        case posterPath
        case productionCompanies
        case productionCountries
        case seasons
        case spokenLanguages
        case status
        case tagline
        case type
        case voteAverage
        case voteCount
    }
}
