import Foundation

public extension TMDB.Account {
    struct WriteResult: Codable, Sendable {
        public let statusCode: Int
        public let statusMessage: String
        @NilBoolean
        public var isSuccess: Bool

        public init(statusCode: Int, statusMessage: String, isSuccess: Bool) {
            self.statusCode = statusCode
            self.statusMessage = statusMessage
            _isSuccess = NilBoolean(wrappedValue: isSuccess)
        }

        enum CodingKeys: String, CodingKey {
            case statusCode
            case statusMessage
            case isSuccess = "success"
        }
    }
}
