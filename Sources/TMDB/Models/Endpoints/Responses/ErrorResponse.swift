import Foundation

public extension TMDB {
    struct ErrorResponse: Codable, Sendable, Equatable {
        public let statusMessage: String
        public let statusCode: String
    }
}
