import Foundation

public extension TMDB {
    struct VideoCollection: Codable, Sendable {
        public let id: Int
        public let results: [Video]
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
