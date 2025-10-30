import Foundation

public extension TMDB {
    struct ErrorResponse: Decodable, Sendable {
        let statusMessage: String
        let statusCode: String
    }
}
