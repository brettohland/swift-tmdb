import Foundation

public extension TMDB.Auth {
    struct V3Session: Codable, Sendable {
        public let sessionID: String
        public let statusCode: Int
        public let statusMessage: String
        public let success: Bool

        public init(
            sessionID: String,
            statusCode: Int,
            statusMessage: String,
            success: Bool,
        ) {
            self.sessionID = sessionID
            self.statusCode = statusCode
            self.statusMessage = statusMessage
            self.success = success
        }

        enum CodingKeys: String, CodingKey {
            case sessionID = "sessionId"
            case statusCode
            case statusMessage
            case success
        }
    }
}
