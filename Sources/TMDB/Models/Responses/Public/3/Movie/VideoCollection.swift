import Foundation

public extension TMDB {
    struct VideoCollection: Codable, Sendable {
        public let id: Int
        public let results: [Video]

        public init(id: Int, results: [Video]) {
            self.id = id
            self.results = results
        }
    }

    struct Video: Codable, Identifiable, Sendable {
        public let id: String
        public let name: String
        public let key: String
        public let site: String
        public let size: Int
        public let type: String
        @NilBoolean
        public var isOfficial: Bool
        public let publishedAt: String

        public init(
            id: String,
            name: String,
            key: String,
            site: String,
            size: Int,
            type: String,
            isOfficial: Bool,
            publishedAt: String,
        ) {
            self.id = id
            self.name = name
            self.key = key
            self.site = site
            self.size = size
            self.type = type
            _isOfficial = NilBoolean(wrappedValue: isOfficial)
            self.publishedAt = publishedAt
        }

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case key
            case site
            case size
            case type
            case isOfficial = "official"
            case publishedAt
        }
    }
}
