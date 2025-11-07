import Foundation

public enum TMDBInitializationError: Error {
    case alreadyInitialized
    case apiKeyMissing
}
