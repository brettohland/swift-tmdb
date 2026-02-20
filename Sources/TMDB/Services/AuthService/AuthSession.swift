import Foundation

public extension TMDB {
    struct AuthSession: Codable, Sendable, Equatable {
        public let accessToken: String
        public let accountID: String
        public let sessionID: String?

        public init(accessToken: String, accountID: String, sessionID: String?) {
            self.accessToken = accessToken
            self.accountID = accountID
            self.sessionID = sessionID
        }

        enum CodingKeys: String, CodingKey {
            case accessToken
            case accountID = "accountId"
            case sessionID = "sessionId"
        }
    }
}
