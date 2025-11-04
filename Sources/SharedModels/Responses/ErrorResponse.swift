import Foundation

public extension TMDBInternal {
    struct ErrorResponse: Codable, Sendable {
        let statusMessage: String
        let statusCode: String
    }
}
