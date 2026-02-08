import Foundation

public extension TMDB {
    struct ImageCollection: Codable, Sendable {
        public let id: Int
        public let backdrops: [ImageDetail]
        public let logos: [ImageDetail]
        public let posters: [ImageDetail]
    }

    struct ImageDetail: Codable, Sendable {
        public let aspectRatio: Double
        public let height: Int
        public let width: Int
        public let filePath: String
        public let voteAverage: Double
        public let voteCount: Int
        public let languageCode: String?

        enum CodingKeys: String, CodingKey {
            case aspectRatio
            case height
            case width
            case filePath
            case voteAverage
            case voteCount
            case languageCode = "iso6391"
        }
    }
}
