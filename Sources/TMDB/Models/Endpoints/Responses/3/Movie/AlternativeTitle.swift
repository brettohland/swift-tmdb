import Foundation

public extension TMDB {
    struct AlternativeTitle: Equatable, Codable, Sendable {
        public let iso31661: Locale.Region
        public let title: String
        public let type: String

        public init(iso31661: Locale.Region, title: String, type: String) {
            self.iso31661 = iso31661
            self.title = title
            self.type = type
        }
    }
}
