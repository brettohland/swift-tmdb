import Foundation

public extension TMDB {
    struct ContentRating: Codable, Sendable {
        public let descriptors: [String]
        @RegionCode
        public var regionCode: Locale.Region
        public let rating: String

        enum CodingKeys: String, CodingKey {
            case descriptors
            case regionCode = "iso31661"
            case rating
        }
    }
}

// Internal wrapper for the content ratings response
struct ContentRatingResponse: Codable {
    let id: Int
    let results: [TMDB.ContentRating]
}
