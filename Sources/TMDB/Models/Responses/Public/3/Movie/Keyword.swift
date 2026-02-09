import Foundation

public extension TMDB {
    struct Keyword: Codable, Identifiable, Sendable, Discoverable {
        public let id: Int
        public let name: String
    }
}
