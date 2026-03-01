import Foundation

/// Errors throws during the initialization
public enum TMDBInitializationError: Error {
    /// The module has already been initialized
    case alreadyInitialized
    /// The module has not yet been initialized
    case notYetInitialized
    /// The image configuration could not be fetched during initialization
    case configurationFetchFailed(any Error)
}
