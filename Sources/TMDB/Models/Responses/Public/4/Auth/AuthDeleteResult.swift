import Foundation

public extension TMDB.Auth {
    struct DeleteResult: Codable, Sendable {
        public let statusCode: Int
        public let statusMessage: String
        public let success: Bool

        public init(
            statusCode: Int,
            statusMessage: String,
            success: Bool,
        ) {
            self.statusCode = statusCode
            self.statusMessage = statusMessage
            self.success = success
        }
    }
}
