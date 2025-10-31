import Foundation

public extension TMDBInternal {
    struct ErrorResponse: Decodable, Sendable {
        let statusMessage: String
        let statusCode: String
    }
}
