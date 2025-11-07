import Foundation

public enum TMDBRequestError: LocalizedError {
    case invalidRequestData
    case networkError(HTTPError)
    case systemError(any Error)
}
