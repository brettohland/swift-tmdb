import Foundation

enum TMDBRequestError: LocalizedError {
    case invalidRequestData
    case errorWithStatus(TMDB.ErrorResponse)
    case networkError(Error)
    case titleIDMissing

    var errorDescription: String? {
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

extension TMDBRequestError: Equatable {
    static func == (lhs: TMDBRequestError, rhs: TMDBRequestError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequestData, .invalidRequestData),
             (.titleIDMissing, .titleIDMissing):
            true
        case (.errorWithStatus(let lResponse), .errorWithStatus(let rResponse)):
            lResponse == rResponse
        case (.networkError(let lError), .networkError(let rError)):
            lError.localizedDescription == rError.localizedDescription
        default:
            false
        }
    }
}
