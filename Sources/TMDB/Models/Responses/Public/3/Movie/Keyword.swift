import Foundation

public extension TMDB {
    struct Keyword: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
    }
}
