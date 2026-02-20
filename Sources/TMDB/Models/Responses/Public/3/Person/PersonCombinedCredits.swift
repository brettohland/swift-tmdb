import Foundation

public extension TMDB {
    struct PersonCombinedCredits: Codable, Identifiable, Sendable {
        public let id: Int
        public let cast: [PersonCombinedCredit]
        public let crew: [PersonCombinedCredit]

        public init(id: Int, cast: [PersonCombinedCredit], crew: [PersonCombinedCredit]) {
            self.id = id
            self.cast = cast
            self.crew = crew
        }
    }

    /// A single credit entry from the combined credits endpoint.
    ///
    /// This type represents both movie and TV credits in a single struct.
    /// Use ``mediaType`` to distinguish between them. Movie-specific fields
    /// (`title`, `originalTitle`, `releaseDate`, `isVideo`) are `nil` for TV credits.
    /// TV-specific fields (`name`, `originalName`, `firstAirDate`, `episodeCount`, `originCountry`)
    /// are `nil` for movie credits. Cast-specific fields (`character`, `order`) and
    /// crew-specific fields (`department`, `job`) are `nil` when not applicable.
    struct PersonCombinedCredit: Sendable {
        public let id: Int
        public let mediaType: String
        // Movie-specific
        public let title: String?
        public let originalTitle: String?
        public let releaseDate: Date?
        @NilBoolean
        public var isVideo: Bool
        // TV-specific
        public let name: String?
        public let originalName: String?
        public let firstAirDate: Date?
        public let episodeCount: Int?
        public let originCountry: [String]?
        // Cast-specific
        public let character: String?
        public let order: Int?
        // Crew-specific
        public let department: String?
        public let job: String?
        // Common
        public let creditID: String
        public let overview: String
        public let posterPath: URL?
        public let backdropPath: URL?
        public let popularity: Double
        public let voteAverage: Double
        public let voteCount: Int
        public let genreIDs: [Int]
        public let originalLanguage: String
        @NilBoolean
        public var isAdult: Bool

        public init(
            id: Int,
            mediaType: String,
            title: String?,
            originalTitle: String?,
            releaseDate: Date?,
            isVideo: Bool,
            name: String?,
            originalName: String?,
            firstAirDate: Date?,
            episodeCount: Int?,
            originCountry: [String]?,
            character: String?,
            order: Int?,
            department: String?,
            job: String?,
            creditID: String,
            overview: String,
            posterPath: URL?,
            backdropPath: URL?,
            popularity: Double,
            voteAverage: Double,
            voteCount: Int,
            genreIDs: [Int],
            originalLanguage: String,
            isAdult: Bool,
        ) {
            self.id = id
            self.mediaType = mediaType
            self.title = title
            self.originalTitle = originalTitle
            self.releaseDate = releaseDate
            _isVideo = NilBoolean(wrappedValue: isVideo)
            self.name = name
            self.originalName = originalName
            self.firstAirDate = firstAirDate
            self.episodeCount = episodeCount
            self.originCountry = originCountry
            self.character = character
            self.order = order
            self.department = department
            self.job = job
            self.creditID = creditID
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.popularity = popularity
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.genreIDs = genreIDs
            self.originalLanguage = originalLanguage
            _isAdult = NilBoolean(wrappedValue: isAdult)
        }
    }
}

// MARK: - Codable

extension TMDB.PersonCombinedCredit: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType
        case title
        case originalTitle
        case releaseDate
        case isVideo = "video"
        case name
        case originalName
        case firstAirDate
        case episodeCount
        case originCountry
        case character
        case order
        case department
        case job
        case creditID = "creditId"
        case overview
        case posterPath
        case backdropPath
        case popularity
        case voteAverage
        case voteCount
        case genreIDs = "genreIds"
        case originalLanguage
        case isAdult = "adult"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        mediaType = try container.decodeIfPresent(String.self, forKey: .mediaType) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)

        if let dateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = try? Date(dateString, strategy: .iso8601.year().month().day())
        } else {
            releaseDate = nil
        }

        _isVideo = try container.decodeIfPresent(NilBoolean.self, forKey: .isVideo) ?? NilBoolean(wrappedValue: false)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        originalName = try container.decodeIfPresent(String.self, forKey: .originalName)

        if let dateString = try container.decodeIfPresent(String.self, forKey: .firstAirDate) {
            firstAirDate = try? Date(dateString, strategy: .iso8601.year().month().day())
        } else {
            firstAirDate = nil
        }

        episodeCount = try container.decodeIfPresent(Int.self, forKey: .episodeCount)
        originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry)
        character = try container.decodeIfPresent(String.self, forKey: .character)
        order = try container.decodeIfPresent(Int.self, forKey: .order)
        department = try container.decodeIfPresent(String.self, forKey: .department)
        job = try container.decodeIfPresent(String.self, forKey: .job)
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID) ?? ""
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        genreIDs = try container.decodeIfPresent([Int].self, forKey: .genreIDs) ?? []
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
        if let releaseDate {
            try container.encode(releaseDate.formatted(.iso8601.year().month().day()), forKey: .releaseDate)
        }
        try container.encode(_isVideo, forKey: .isVideo)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(originalName, forKey: .originalName)
        if let firstAirDate {
            try container.encode(firstAirDate.formatted(.iso8601.year().month().day()), forKey: .firstAirDate)
        }
        try container.encodeIfPresent(episodeCount, forKey: .episodeCount)
        try container.encodeIfPresent(originCountry, forKey: .originCountry)
        try container.encodeIfPresent(character, forKey: .character)
        try container.encodeIfPresent(order, forKey: .order)
        try container.encodeIfPresent(department, forKey: .department)
        try container.encodeIfPresent(job, forKey: .job)
        try container.encode(creditID, forKey: .creditID)
        try container.encode(overview, forKey: .overview)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(genreIDs, forKey: .genreIDs)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(_isAdult, forKey: .isAdult)
    }
}
