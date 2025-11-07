import Foundation

extension TMDB.Credits {
    struct Details: Codable, Identifiable {
        let creditType: String
        let department: String
        let job: String
        let media: Media
        let mediaType: String
        let id: String
        let person: Person

        init(
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
        let adult: Bool
        let backdropPath: String
        let id: Int
        let name: String
        @LanguageCode
        var originalLanguage: Locale.Language
        let originalName: String
        let overview: String
        let posterPath: String
        let mediaType: String
        let genreIDs: [Int]
        let popularity: Double
        @ISO8601YMD
        var firstAirDate: Date?
        let voteAverage: Double
        let voteCount: Int
        let originCountry: [Locale.Region]
        let seasons: [Season]

        init(
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
        var airDate: Date?
        let episodeCount: Int
        let id: Int
        let name: String
        let overview: String
        let posterPath: String
        let seasonNumber: Int
        let showID: Int

        init(
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
        let adult: Bool
        let id: Int
        let name: String
        let originalName: String
        let mediaType: String
        let popularity: Double
        let gender: Int
        let knownForDepartment: String
        let profilePath: String

        init(
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
