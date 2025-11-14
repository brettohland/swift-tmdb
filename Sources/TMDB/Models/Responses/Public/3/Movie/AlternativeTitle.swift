import Foundation

public extension TMDB {
    struct AlternativeTitle: Equatable, Codable, Sendable {
        public let iso31661: Locale.Region
        public let title: String
        public let type: String
    }
}
