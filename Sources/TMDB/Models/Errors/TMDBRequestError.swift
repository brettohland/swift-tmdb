import Foundation

/// Errors thrown during requests
public enum TMDBRequestError: Error {
    /// The request to the TMDB API failed
    case networkError(TMDBAPIError)
    /// A "catch-all" for other errors thrown by the system (including decoding issues)
    case systemError(any Error)
    /// The user cancelled the authentication flow
    case authenticationCancelled
    /// An authentication flow is already in progress
    case authenticationAlreadyInProgress
    /// No authenticated session is available
    case notAuthenticated
}

extension TMDBRequestError: Equatable {
    public static func == (lhs: TMDBRequestError, rhs: TMDBRequestError) -> Bool {
        switch (lhs, rhs) {
        case (.networkError(let lhsError), .networkError(let rhsError)):
            lhsError == rhsError
        case (.systemError(let lhsError), .systemError(let rhsError)):
            "\(lhsError)" == "\(rhsError)"
        case (.authenticationCancelled, .authenticationCancelled):
            true
        case (.authenticationAlreadyInProgress, .authenticationAlreadyInProgress):
            true
        case (.notAuthenticated, .notAuthenticated):
            true
        default:
            false
        }
    }

}
