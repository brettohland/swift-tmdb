import Foundation

public extension TMDB {
    /// Represents a content rating certification
    struct Certification: Codable, Sendable {
        public let certification: String
        public let meaning: String
        public let order: Int
    }
}
