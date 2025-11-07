import Foundation

public extension TMDB {
    struct Movie: Sendable {
        public let isAdult: Bool
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

        public init(
            isAdult: Bool,
            backdropPath: String,
            belongsToCollection: TitleCollection,
            budget: Int,
            genres: [Genre],
            homepage: URL,
            id: Int,
            imdbID: String,
            originalLanguage: Locale.Region,
            originalTitle: String,
            overview: String,
            popularity: Double,
            posterPath: String,
            productionCompanies: [ProductionCompany],
            productionCountries: [Locale.Region],
            releaseDate: Date? = nil,
            revenue: Int,
            runtime: Measurement<UnitDuration>,
            spokenLanguages: [Locale.Language],
            status: ReleaseStatus,
            tagline: String,
            title: String,
            video: Bool,
            voteAverage: Double,
            voteCount: Int
        ) {
            self.isAdult = isAdult
            self.backdropPath = backdropPath
            self.belongsToCollection = belongsToCollection
            self.budget = budget
            self.genres = genres
            self.homepage = homepage
            self.id = id
            self.imdbID = imdbID
            self.originalLanguage = originalLanguage
            self.originalTitle = originalTitle
            self.overview = overview
            self.popularity = popularity
            self.posterPath = posterPath
            self.productionCompanies = productionCompanies
            _productionCountries = RegionArray(wrappedValue: productionCountries)
            _releaseDate = ISO8601YMD(wrappedValue: releaseDate)
            self.revenue = revenue
            _runtime = Minutes(wrappedValue: runtime)
            _spokenLanguages = LanguageArray(wrappedValue: spokenLanguages)
            self.status = status
            self.tagline = tagline
            self.title = title
            self.video = video
            self.voteAverage = voteAverage
            self.voteCount = voteCount
        }
    }


}

extension TMDB.Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
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
