import Foundation

public extension TMDB.Account {
    struct AccountList: Codable, Sendable {
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
        public let accountObjectID: String
        public let revenue: String
        public let featured: Int
        public let sortBy: Int

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
            accountObjectID: String,
            revenue: String,
            featured: Int,
            sortBy: Int,
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
            self.accountObjectID = accountObjectID
            self.revenue = revenue
            self.featured = featured
            self.sortBy = sortBy
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
            case accountObjectID = "accountObjectId"
            case revenue
            case featured
            case sortBy
        }
    }
}

extension TMDB.Account.AccountList: Discoverable {}
