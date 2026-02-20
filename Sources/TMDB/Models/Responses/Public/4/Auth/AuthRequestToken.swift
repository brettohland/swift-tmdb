import Foundation

public extension TMDB.Auth {
    struct RequestToken: Codable, Sendable {
        public let requestToken: String
        public let statusCode: Int
        public let statusMessage: String
        public let success: Bool

        public init(
            requestToken: String,
            statusCode: Int,
            statusMessage: String,
            success: Bool,
        ) {
            self.requestToken = requestToken
            self.statusCode = statusCode
            self.statusMessage = statusMessage
            self.success = success
        }
    }
}
