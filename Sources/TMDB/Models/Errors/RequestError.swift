import Foundation

public extension TMDB {
    enum RequestError: LocalizedError {
        case invalidRequestData
        case errorWithStatus(ErrorResponse)
        case networkError(Error)
        case titleIDMissing

        public var errorDescription: String? {
            switch self {
            case .invalidRequestData:
                "The data returned by the server was in an incorrect format."
            case .errorWithStatus(let status):
                "Server error \(status.statusCode): \(status.statusMessage)"
            case .networkError(let networkError):
                networkError.localizedDescription
            case .titleIDMissing:
                "The returned title is missing it's ID"
            }
        }
    }
}
