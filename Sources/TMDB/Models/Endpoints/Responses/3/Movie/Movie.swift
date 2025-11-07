import Foundation

public extension TMDB {
    struct Movie: Sendable {
        public let adult: Bool
        public let backdropPath: String
        public let belongsToCollection: TitleCollection
        public let budget: Int
        public let genres: [Genre]
        public let homepage: URL
        public let id: Int
        public let imdbID: String
        public let originalLanguage: Locale.Region
        public let originalTitle: String
        public let overview: String
        public let popularity: Double
        public let posterPath: String
        public let productionCompanies: [ProductionCompany]
        @RegionArray
        public var productionCountries: [Locale.Region]
        @ISO8601YMD
        public var releaseDate: Date?
        public let revenue: Int
        @Minutes
        public var runtime: Measurement<UnitDuration>
        @LanguageArray
        public var spokenLanguages: [Locale.Language]
        public let status: ReleaseStatus
        public let tagline: String
        public let title: String
        public let video: Bool
        public let voteAverage: Double
        public let voteCount: Int
    }
}

extension TMDB.Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case belongsToCollection
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdbId"
        case originalLanguage
        case originalTitle
        case overview
        case popularity
        case posterPath
        case productionCompanies
        case productionCountries
        case releaseDate
        case revenue
        case runtime
        case spokenLanguages
        case status
        case tagline
        case title
        case video
        case voteAverage
        case voteCount
    }
}
