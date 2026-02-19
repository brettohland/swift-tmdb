import Foundation

public extension TMDB.Auth {
    struct AccessToken: Codable, Sendable {
        public let accessToken: String
        public let accountID: String
        public let statusCode: Int
        public let statusMessage: String
        public let success: Bool

        public init(
            accessToken: String,
            accountID: String,
            statusCode: Int,
            statusMessage: String,
            success: Bool,
        ) {
            self.accessToken = accessToken
            self.accountID = accountID
            self.statusCode = statusCode
            self.statusMessage = statusMessage
            self.success = success
        }

        enum CodingKeys: String, CodingKey {
            case accessToken
            case accountID = "accountId"
            case statusCode
            case statusMessage
            case success
        }
    }
}
