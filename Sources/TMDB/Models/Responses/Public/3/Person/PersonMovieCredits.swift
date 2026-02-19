import Foundation

public extension TMDB {
    struct PersonMovieCredits: Codable, Identifiable, Sendable {
        public let id: Int
        public let cast: [PersonMovieCastCredit]
        public let crew: [PersonMovieCrewCredit]

        public init(id: Int, cast: [PersonMovieCastCredit], crew: [PersonMovieCrewCredit]) {
            self.id = id
            self.cast = cast
            self.crew = crew
        }
    }

    struct PersonMovieCastCredit: Sendable {
        public let id: Int
        public let title: String
        public let originalTitle: String
        public let character: String
        public let creditID: String
        public let releaseDate: Date?
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
        @NilBoolean
        public var isVideo: Bool
        public let order: Int

        public init(
            id: Int,
            title: String,
            originalTitle: String,
            character: String,
            creditID: String,
            releaseDate: Date?,
            overview: String,
            posterPath: URL?,
            backdropPath: URL?,
            popularity: Double,
            voteAverage: Double,
            voteCount: Int,
            genreIDs: [Int],
            originalLanguage: String,
            isAdult: Bool,
            isVideo: Bool,
            order: Int,
        ) {
            self.id = id
            self.title = title
            self.originalTitle = originalTitle
            self.character = character
            self.creditID = creditID
            self.releaseDate = releaseDate
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.popularity = popularity
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.genreIDs = genreIDs
            self.originalLanguage = originalLanguage
            _isAdult = NilBoolean(wrappedValue: isAdult)
            _isVideo = NilBoolean(wrappedValue: isVideo)
            self.order = order
        }
    }

    struct PersonMovieCrewCredit: Sendable {
        public let id: Int
        public let title: String
        public let originalTitle: String
        public let department: String
        public let job: String
        public let creditID: String
        public let releaseDate: Date?
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
        @NilBoolean
        public var isVideo: Bool

        public init(
            id: Int,
            title: String,
            originalTitle: String,
            department: String,
            job: String,
            creditID: String,
            releaseDate: Date?,
            overview: String,
            posterPath: URL?,
            backdropPath: URL?,
            popularity: Double,
            voteAverage: Double,
            voteCount: Int,
            genreIDs: [Int],
            originalLanguage: String,
            isAdult: Bool,
            isVideo: Bool,
        ) {
            self.id = id
            self.title = title
            self.originalTitle = originalTitle
            self.department = department
            self.job = job
            self.creditID = creditID
            self.releaseDate = releaseDate
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.popularity = popularity
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.genreIDs = genreIDs
            self.originalLanguage = originalLanguage
            _isAdult = NilBoolean(wrappedValue: isAdult)
            _isVideo = NilBoolean(wrappedValue: isVideo)
        }
    }
}

// MARK: - Codable

extension TMDB.PersonMovieCastCredit: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle
        case character
        case creditID = "creditId"
        case releaseDate
        case overview
        case posterPath
        case backdropPath
        case popularity
        case voteAverage
        case voteCount
        case genreIDs = "genreIds"
        case originalLanguage
        case isAdult = "adult"
        case isVideo = "video"
        case order
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
        character = try container.decodeIfPresent(String.self, forKey: .character) ?? ""
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID) ?? ""

        if let dateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = try? Date(dateString, strategy: .iso8601.year().month().day())
        } else {
            releaseDate = nil
        }

        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        genreIDs = try container.decodeIfPresent([Int].self, forKey: .genreIDs) ?? []
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
        _isVideo = try container.decodeIfPresent(NilBoolean.self, forKey: .isVideo) ?? NilBoolean(wrappedValue: false)
        order = try container.decodeIfPresent(Int.self, forKey: .order) ?? 0
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(character, forKey: .character)
        try container.encode(creditID, forKey: .creditID)
        if let releaseDate {
            try container.encode(releaseDate.formatted(.iso8601.year().month().day()), forKey: .releaseDate)
        }
        try container.encode(overview, forKey: .overview)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(genreIDs, forKey: .genreIDs)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(_isAdult, forKey: .isAdult)
        try container.encode(_isVideo, forKey: .isVideo)
        try container.encode(order, forKey: .order)
    }
}

extension TMDB.PersonMovieCrewCredit: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle
        case department
        case job
        case creditID = "creditId"
        case releaseDate
        case overview
        case posterPath
        case backdropPath
        case popularity
        case voteAverage
        case voteCount
        case genreIDs = "genreIds"
        case originalLanguage
        case isAdult = "adult"
        case isVideo = "video"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
        department = try container.decodeIfPresent(String.self, forKey: .department) ?? ""
        job = try container.decodeIfPresent(String.self, forKey: .job) ?? ""
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID) ?? ""

        if let dateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = try? Date(dateString, strategy: .iso8601.year().month().day())
        } else {
            releaseDate = nil
        }

        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        genreIDs = try container.decodeIfPresent([Int].self, forKey: .genreIDs) ?? []
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
        _isVideo = try container.decodeIfPresent(NilBoolean.self, forKey: .isVideo) ?? NilBoolean(wrappedValue: false)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(department, forKey: .department)
        try container.encode(job, forKey: .job)
        try container.encode(creditID, forKey: .creditID)
        if let releaseDate {
            try container.encode(releaseDate.formatted(.iso8601.year().month().day()), forKey: .releaseDate)
        }
        try container.encode(overview, forKey: .overview)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(genreIDs, forKey: .genreIDs)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(_isAdult, forKey: .isAdult)
        try container.encode(_isVideo, forKey: .isVideo)
    }
}
