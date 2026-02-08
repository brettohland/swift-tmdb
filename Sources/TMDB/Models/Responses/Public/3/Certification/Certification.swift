import Foundation

public extension TMDB {
    /// Represents a content rating certification
    struct Certification: Codable, Sendable {
        public let rating: String
        public let meaning: String
        public let order: Int

        enum CodingKeys: String, CodingKey {
            case rating = "certification"
            case meaning
            case order
        }
    }
}
