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
                return "The data returned by the server was in an incorrect format."
            case .errorWithStatus(let status):
                return "Server error \(status.statusCode): \(status.statusMessage)"
            case .networkError(let networkError):
                return networkError.localizedDescription
            case .titleIDMissing:
                return "The returned title is missing it's ID"
            }
        }
    }
}
