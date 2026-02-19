import Foundation

public extension TMDB.Account {
    struct AccountRating: Codable, Sendable {
        public let createdAt: String
        public let value: Double

        public init(createdAt: String, value: Double) {
            self.createdAt = createdAt
            self.value = value
        }
    }
}
