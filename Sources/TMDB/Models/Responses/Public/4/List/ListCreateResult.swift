import Foundation

public extension TMDB.List {
    /// The result of creating a new list
    struct CreateResult: Codable, Sendable {
        public let id: Int
        public let statusCode: Int
        public let statusMessage: String
        @NilBoolean
        public var isSuccess: Bool

        public init(id: Int, statusCode: Int, statusMessage: String, isSuccess: Bool) {
            self.id = id
            self.statusCode = statusCode
            self.statusMessage = statusMessage
            _isSuccess = NilBoolean(wrappedValue: isSuccess)
        }

        enum CodingKeys: String, CodingKey {
            case id
            case statusCode
            case statusMessage
            case isSuccess = "success"
        }
    }
}
