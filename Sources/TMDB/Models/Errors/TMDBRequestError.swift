import Foundation

/// Represents errors from the TMDBSwifty SDK
public enum TMDBRequestError: Error {
    /// The request to the TMDB API failed
    case networkError(TMDBAPIError)
    /// A "catch-all" for other errors thrown by the system (including decoding issues)
    case systemError(any Error)
}

extension TMDBRequestError: Equatable {
    public static func == (lhs: TMDBRequestError, rhs: TMDBRequestError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError(let lhsError), .networkError(let rhsError)):
            lhsError == rhsError
        case (.systemError(let lhsError), .systemError(let rhsError)):
            "\(lhsError)" == "\(rhsError)"
        default:
            false
        }
    }

}
