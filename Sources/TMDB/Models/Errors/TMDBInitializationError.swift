import Foundation

/// Errors throws during the initialization of the TMDBSwifty SDK
public enum TMDBInitializationError: Error {
    /// The TMDBSwifty SDK has already been initialized
    case alreadyInitialized
    /// The TMDBSwifty SDK has not been initialized
    case notYetInitialized
}
