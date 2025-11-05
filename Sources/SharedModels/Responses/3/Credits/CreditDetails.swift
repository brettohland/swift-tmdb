import Foundation

public extension TMDBInternal.Credits {
    struct Details: Codable, Identifiable {
        public let creditType: String
        public let department: String
        public let job: String
        public let media: Media
        public let mediaType: String
        public let id: String
        public let person: Person

        public init(
            creditType: String,
            department: String,
            job: String,
            media: Media,
            mediaType: String,
            id: String,
            person: Person,
        ) {
            self.creditType = creditType
            self.department = department
            self.job = job
            self.media = media
            self.mediaType = mediaType
            self.id = id
            self.person = person
        }
    }

    struct Media: Codable, Identifiable {
        public let adult: Bool
        public let backdropPath: String
        public let id: Int
        public let name: String
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let originalName: String
        public let overview: String
        public let posterPath: String
        public let mediaType: String
        public let genreIDs: [Int]
        public let popularity: Double
        @ISO8601YMD
        public var firstAirDate: Date?
        public let voteAverage: Double
        public let voteCount: Int
        public let originCountry: [Locale.Region]
        public let seasons: [Season]

        public init(
            adult: Bool,
            backdropPath: String,
            id: Int,
            name: String,
            originalLanguage: Locale.Language,
            originalName: String,
            overview: String,
            posterPath: String,
            mediaType: String,
            genreIDs: [Int],
            popularity: Double,
            firstAirDate: Date?,
            voteAverage: Double,
            voteCount: Int,
            originCountry: [Locale.Region],
            seasons: [Season],
        ) {
            self.adult = adult
            self.backdropPath = backdropPath
            self.id = id
            self.name = name
            _originalLanguage = LanguageCode(wrappedValue: originalLanguage)
            self.originalName = originalName
            self.overview = overview
            self.posterPath = posterPath
            self.mediaType = mediaType
            self.genreIDs = genreIDs
            self.popularity = popularity
            _firstAirDate = ISO8601YMD(wrappedValue: firstAirDate)
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.originCountry = originCountry
            self.seasons = seasons
        }

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath
            case id
            case name
            case originalLanguage
            case originalName
            case overview
            case posterPath
            case mediaType
            case genreIDs = "genreIds"
            case popularity
            case firstAirDate
            case voteAverage
            case voteCount
            case originCountry
            case seasons
        }
    }

    struct Season: Codable, Identifiable {
        @ISO8601YMD
        public var airDate: Date?
        public let episodeCount: Int
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: String
        public let seasonNumber: Int
        public let showID: Int

        public init(
            airDate: Date? = nil,
            episodeCount: Int,
            id: Int,
            name: String,
            overview: String,
            posterPath: String,
            seasonNumber: Int,
            showID: Int,
        ) {
            _airDate = ISO8601YMD(wrappedValue: airDate)
            self.episodeCount = episodeCount
            self.id = id
            self.name = name
            self.overview = overview
            self.posterPath = posterPath
            self.seasonNumber = seasonNumber
            self.showID = showID
        }

        enum CodingKeys: String, CodingKey {
            case airDate
            case episodeCount
            case id
            case name
            case overview
            case posterPath
            case seasonNumber
            case showID = "showId"
        }
    }

    struct Person: Codable, Identifiable {
        public let adult: Bool
        public let id: Int
        public let name: String
        public let originalName: String
        public let mediaType: String
        public let popularity: Double
        public let gender: Int
        public let knownForDepartment: String
        public let profilePath: String

        public init(
            adult: Bool,
            id: Int,
            name: String,
            originalName: String,
            mediaType: String,
            popularity: Double,
            gender: Int,
            knownForDepartment: String,
            profilePath: String,
        ) {
            self.adult = adult
            self.id = id
            self.name = name
            self.originalName = originalName
            self.mediaType = mediaType
            self.popularity = popularity
            self.gender = gender
            self.knownForDepartment = knownForDepartment
            self.profilePath = profilePath
        }
    }
}
