import Foundation

public extension TMDB {
    struct AlternativeTitle: Equatable, Codable, Sendable {
        public let regionCode: Locale.Region
        public let title: String
        public let type: String

        public init(regionCode: Locale.Region, title: String, type: String) {
            self.regionCode = regionCode
            self.title = title
            self.type = type
        }

        enum CodingKeys: String, CodingKey {
            case regionCode = "iso31661"
            case title
            case type
        }
    }
}
