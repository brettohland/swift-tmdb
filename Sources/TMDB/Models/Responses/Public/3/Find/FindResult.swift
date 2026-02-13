import Foundation

public extension TMDB {
    struct FindResult: Codable, Sendable {
        public let movieResults: [Discover.DiscoverMovie]
        public let tvResults: [Discover.DiscoverTV]
        public let personResults: [FindPerson]
        public let tvEpisodeResults: [FindTVEpisode]
        public let tvSeasonResults: [FindTVSeason]

        public init(
            movieResults: [Discover.DiscoverMovie],
            tvResults: [Discover.DiscoverTV],
            personResults: [FindPerson],
            tvEpisodeResults: [FindTVEpisode],
            tvSeasonResults: [FindTVSeason],
        ) {
            self.movieResults = movieResults
            self.tvResults = tvResults
            self.personResults = personResults
            self.tvEpisodeResults = tvEpisodeResults
            self.tvSeasonResults = tvSeasonResults
        }
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
        public let profilePath: URL?
        public let knownForDepartment: String?

        public init(
            id: Int,
            name: String,
            isAdult: Bool,
            gender: Int?,
            popularity: Double?,
            profilePath: URL?,
            knownForDepartment: String?,
        ) {
            self.id = id
            self.name = name
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.gender = gender
            self.popularity = popularity
            self.profilePath = profilePath
            self.knownForDepartment = knownForDepartment
        }

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
        public let stillPath: URL?

        public init(
            id: Int,
            name: String,
            overview: String,
            voteAverage: Double?,
            voteCount: Int?,
            airDate: Date?,
            episodeNumber: Int,
            seasonNumber: Int,
            showID: Int,
            stillPath: URL?,
        ) {
            self.id = id
            self.name = name
            self.overview = overview
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            _airDate = ISO8601YMD(wrappedValue: airDate)
            self.episodeNumber = episodeNumber
            self.seasonNumber = seasonNumber
            self.showID = showID
            self.stillPath = stillPath
        }

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
        public let posterPath: URL?
        public let seasonNumber: Int
        public let showID: Int

        public init(
            id: Int,
            name: String,
            overview: String,
            airDate: Date?,
            posterPath: URL?,
            seasonNumber: Int,
            showID: Int,
        ) {
            self.id = id
            self.name = name
            self.overview = overview
            _airDate = ISO8601YMD(wrappedValue: airDate)
            self.posterPath = posterPath
            self.seasonNumber = seasonNumber
            self.showID = showID
        }

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
