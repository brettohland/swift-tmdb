import Foundation

public extension TMDB {
    struct ReleaseDateResult: Codable, Sendable {
        @RegionCode
        public var regionCode: Locale.Region
        public let releaseDates: [ReleaseDate]

        enum CodingKeys: String, CodingKey {
            case regionCode = "iso31661"
            case releaseDates
        }
    }

    struct ReleaseDate: Codable, Sendable {
        public let certification: String
        public let languageCode: String
        public let releaseDate: String
        public let type: Int
        public let note: String?

        enum CodingKeys: String, CodingKey {
            case certification
            case languageCode = "iso6391"
            case releaseDate
            case type
            case note
        }
    }
}
