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
        public let tagline: String?
        public let type: String
        public let voteAverage: Double
        public let voteCount: Int

        public init(
            isAdult: Bool,
            backdropPath: URL?,
            createdBy: [Creator],
            episodeRunTime: [Int],
            firstAirDate: Date?,
            genres: [Genre],
            homepage: URL?,
            id: Int,
            isInProduction: Bool,
            languages: [String],
            lastAirDate: Date?,
            lastEpisodeToAir: EpisodeOverview?,
            name: String,
            nextEpisodeToAir: EpisodeOverview?,
            networks: [Network],
            numberOfEpisodes: Int,
            numberOfSeasons: Int,
            originCountry: [String],
            originalLanguage: String,
            originalName: String,
            overview: String,
            popularity: Double,
            posterPath: URL?,
            productionCompanies: [ProductionCompany],
            productionCountries: [Locale.Region],
            seasons: [SeasonOverview],
            spokenLanguages: [Locale.Language],
            status: String,
            tagline: String?,
            type: String,
            voteAverage: Double,
            voteCount: Int,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.backdropPath = backdropPath
            self.createdBy = createdBy
            self.episodeRunTime = episodeRunTime
            _firstAirDate = ISO8601YMD(wrappedValue: firstAirDate)
            self.genres = genres
            _homepage = EmptyStringNullable(wrappedValue: homepage)
            self.id = id
            _isInProduction = NilBoolean(wrappedValue: isInProduction)
            self.languages = languages
            _lastAirDate = ISO8601YMD(wrappedValue: lastAirDate)
            self.lastEpisodeToAir = lastEpisodeToAir
            self.name = name
            self.nextEpisodeToAir = nextEpisodeToAir
            self.networks = networks
            self.numberOfEpisodes = numberOfEpisodes
            self.numberOfSeasons = numberOfSeasons
            self.originCountry = originCountry
            self.originalLanguage = originalLanguage
            self.originalName = originalName
            self.overview = overview
            self.popularity = popularity
            self.posterPath = posterPath
            self.productionCompanies = productionCompanies
            _productionCountries = RegionArray(wrappedValue: productionCountries)
            self.seasons = seasons
            _spokenLanguages = LanguageArray(wrappedValue: spokenLanguages)
            self.status = status
            self.tagline = tagline
            self.type = type
            self.voteAverage = voteAverage
            self.voteCount = voteCount
        }
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

        public init(id: Int, creditID: String, name: String, originalName: String, gender: Int, profilePath: URL?) {
            self.id = id
            self.creditID = creditID
            self.name = name
            self.originalName = originalName
            self.gender = gender
            self.profilePath = profilePath
        }

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

        public init(id: Int, name: String, logoPath: URL?, originCountry: String) {
            self.id = id
            self.name = name
            self.logoPath = logoPath
            self.originCountry = originCountry
        }

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

        public init(
            id: Int,
            name: String,
            overview: String,
            posterPath: URL?,
            airDate: Date?,
            episodeCount: Int,
            seasonNumber: Int,
            voteAverage: Double,
        ) {
            self.id = id
            self.name = name
            self.overview = overview
            self.posterPath = posterPath
            _airDate = ISO8601YMD(wrappedValue: airDate)
            self.episodeCount = episodeCount
            self.seasonNumber = seasonNumber
            self.voteAverage = voteAverage
        }

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

        public init(
            id: Int,
            name: String,
            overview: String,
            episodeNumber: Int,
            seasonNumber: Int,
            airDate: Date?,
            stillPath: URL?,
            voteAverage: Double,
            voteCount: Int,
            runtime: Int?,
            productionCode: String,
            showID: Int,
        ) {
            self.id = id
            self.name = name
            self.overview = overview
            self.episodeNumber = episodeNumber
            self.seasonNumber = seasonNumber
            _airDate = ISO8601YMD(wrappedValue: airDate)
            self.stillPath = stillPath
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.runtime = runtime
            self.productionCode = productionCode
            self.showID = showID
        }

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
