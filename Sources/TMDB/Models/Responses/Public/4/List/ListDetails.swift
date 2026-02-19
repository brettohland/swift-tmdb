import Foundation

public extension TMDB.List {
    /// The details and items of a v4 list
    struct Details: Codable, Sendable {
        public let id: Int
        public let name: String
        public let description: String
        public let posterPath: URL?
        public let backdropPath: URL?
        public let numberOfItems: Int
        public let isPublic: Int
        public let averageRating: Double
        public let runtime: Int
        @RegionCode
        public var regionCode: Locale.Region
        @LanguageCode
        public var languageCode: Locale.Language
        public let createdAt: String
        public let updatedAt: String
        public let createdBy: Creator
        public let page: Int
        public let totalPages: Int
        public let totalResults: Int
        public let results: [Item]
        public let revenue: String
        public let featured: Int
        public let sortBy: String
        public let comments: [String: String?]

        public init(
            id: Int,
            name: String,
            description: String,
            posterPath: URL?,
            backdropPath: URL?,
            numberOfItems: Int,
            isPublic: Int,
            averageRating: Double,
            runtime: Int,
            regionCode: Locale.Region,
            languageCode: Locale.Language,
            createdAt: String,
            updatedAt: String,
            createdBy: Creator,
            page: Int,
            totalPages: Int,
            totalResults: Int,
            results: [Item],
            revenue: String,
            featured: Int,
            sortBy: String,
            comments: [String: String?],
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.numberOfItems = numberOfItems
            self.isPublic = isPublic
            self.averageRating = averageRating
            self.runtime = runtime
            _regionCode = RegionCode(wrappedValue: regionCode)
            _languageCode = LanguageCode(wrappedValue: languageCode)
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.createdBy = createdBy
            self.page = page
            self.totalPages = totalPages
            self.totalResults = totalResults
            self.results = results
            self.revenue = revenue
            self.featured = featured
            self.sortBy = sortBy
            self.comments = comments
        }

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case posterPath
            case backdropPath
            case numberOfItems
            case isPublic = "public"
            case averageRating
            case runtime
            case regionCode = "iso31661"
            case languageCode = "iso6391"
            case createdAt
            case updatedAt
            case createdBy
            case page
            case totalPages
            case totalResults
            case results
            case revenue
            case featured
            case sortBy
            case comments
        }
    }
}

public extension TMDB.List {
    /// The creator of a list
    struct Creator: Codable, Sendable {
        public let id: String
        public let name: String
        public let username: String
        public let gravatarHash: String

        public init(id: String, name: String, username: String, gravatarHash: String) {
            self.id = id
            self.name = name
            self.username = username
            self.gravatarHash = gravatarHash
        }

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case username
            case gravatarHash = "avatarPath"
        }
    }
}
