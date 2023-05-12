import Foundation

public extension TMDB {
    struct ErrorResponse: Decodable {
        let statusMessage: String
        let statusCode: String
    }
}
