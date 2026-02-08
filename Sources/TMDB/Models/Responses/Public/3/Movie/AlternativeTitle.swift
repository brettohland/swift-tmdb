import Foundation

public extension TMDB {
    struct AlternativeTitle: Equatable, Codable, Sendable {
        public let regionCode: Locale.Region
        public let title: String
        public let type: String

        enum CodingKeys: String, CodingKey {
            case regionCode = "iso31661"
            case title
            case type
        }
    }
}
