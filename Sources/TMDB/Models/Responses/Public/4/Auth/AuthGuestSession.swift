import Foundation

public extension TMDB.Auth {
    struct GuestSession: Codable, Sendable {
        @NilBoolean
        public var isSuccess: Bool
        public let guestSessionID: String
        public let expiresAt: String

        public init(
            isSuccess: Bool,
            guestSessionID: String,
            expiresAt: String,
        ) {
            _isSuccess = NilBoolean(wrappedValue: isSuccess)
            self.guestSessionID = guestSessionID
            self.expiresAt = expiresAt
        }

        enum CodingKeys: String, CodingKey {
            case isSuccess = "success"
            case guestSessionID = "guestSessionId"
            case expiresAt
        }
    }
}
