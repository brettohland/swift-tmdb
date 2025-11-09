import Foundation

public enum TMDBRequestError: LocalizedError {
    case invalidRequestData
    case networkError(HTTPError)
    case systemError(any Error)
}

extension TMDBRequestError: Equatable {
    public static func == (lhs: TMDBRequestError, rhs: TMDBRequestError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequestData, .invalidRequestData):
            true
        case (.networkError(let lhsError), .networkError(let rhsError)):
            lhsError == rhsError
        case (.systemError(let lhsError), .systemError(let rhsError)):
            "\(lhsError)" == "\(rhsError)"
        default:
            false
        }
    }

}
