import Foundation

public extension TMDB.Credits {
    struct Media: Codable, Identifiable, Sendable {
        @NilBoolean public var isAdult: Bool
        public let backdropPath: URL?
        public let id: Int
        public let mediaType: String
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let overview: String
        public let posterPath: URL?
        public let genreIDs: [Int]
        public let popularity: Double
        public let voteAverage: Double
        public let voteCount: Int

        // TV-specific fields
        public let name: String?
        public let originalName: String?
        @ISO8601YMD
        public var firstAirDate: Date?
        public let originCountry: [Locale.Region]?
        public let seasons: [Season]

        // Movie-specific fields
        public let title: String?
        public let originalTitle: String?
        @ISO8601YMD
        public var releaseDate: Date?

        public init(
            isAdult: Bool,
            backdropPath: URL?,
            id: Int,
            mediaType: String,
            originalLanguage: Locale.Language,
            overview: String,
            posterPath: URL?,
            genreIDs: [Int],
            popularity: Double,
            voteAverage: Double,
            voteCount: Int,
            name: String?,
            originalName: String?,
            firstAirDate: Date?,
            originCountry: [Locale.Region]?,
            seasons: [Season],
            title: String?,
            originalTitle: String?,
            releaseDate: Date?,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.backdropPath = backdropPath
            self.id = id
            self.mediaType = mediaType
            _originalLanguage = LanguageCode(wrappedValue: originalLanguage)
            self.overview = overview
            self.posterPath = posterPath
            self.genreIDs = genreIDs
            self.popularity = popularity
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.name = name
            self.originalName = originalName
            _firstAirDate = ISO8601YMD(wrappedValue: firstAirDate)
            self.originCountry = originCountry
            self.seasons = seasons
            self.title = title
            self.originalTitle = originalTitle
            _releaseDate = ISO8601YMD(wrappedValue: releaseDate)
        }

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case backdropPath
            case id
            case mediaType
            case originalLanguage
            case overview
            case posterPath
            case genreIDs = "genreIds"
            case popularity
            case voteAverage
            case voteCount
            case name
            case originalName
            case firstAirDate
            case originCountry
            case seasons
            case title
            case originalTitle
            case releaseDate
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            _isAdult = try container
                .decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
            backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
            id = try container.decode(Int.self, forKey: .id)
            mediaType = try container.decode(String.self, forKey: .mediaType)
            _originalLanguage = try container.decode(LanguageCode.self, forKey: .originalLanguage)
            overview = try container.decode(String.self, forKey: .overview)
            posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
            genreIDs = try container.decode([Int].self, forKey: .genreIDs)
            popularity = try container.decode(Double.self, forKey: .popularity)
            voteAverage = try container.decode(Double.self, forKey: .voteAverage)
            voteCount = try container.decode(Int.self, forKey: .voteCount)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
            _firstAirDate = try container
                .decodeIfPresent(ISO8601YMD.self, forKey: .firstAirDate) ?? ISO8601YMD(wrappedValue: nil)
            originCountry = try container.decodeIfPresent([Locale.Region].self, forKey: .originCountry)
            seasons = try container.decodeIfPresent([Season].self, forKey: .seasons) ?? []
            title = try container.decodeIfPresent(String.self, forKey: .title)
            originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
            _releaseDate = try container
                .decodeIfPresent(ISO8601YMD.self, forKey: .releaseDate) ?? ISO8601YMD(wrappedValue: nil)
        }
    }
}
