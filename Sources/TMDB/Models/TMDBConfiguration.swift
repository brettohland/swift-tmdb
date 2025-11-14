import Foundation

/// A configuration struct used by the package to configure itself.
public struct TMDBConfiguration: Sendable {
    /// Your TMDB API Key
    public let apiKey: String
    /// An optional configuration for all URLSessions internally to the module to use in all requests
    public let urlSessionConfiguration: URLSessionConfiguration
    /// The minimum logging level to use when outputting logs to OSLog
    public let minimumLoggingLevel: TMDB.LoggingLevel

    /// Initialize a new TMDBConfiguration struct
    /// - Parameters:
    ///   - apiKey: Your TMDB API Key
    ///   - urlSessionConfiguration: An optional configuration for all URLSessions internally to the module to use in
    ///   all requests (Defaults to `.default`)
    ///   - minimumLoggingLevel: The minimum logging level to use when outputting logs to OSLog (Defaults
    ///   to ``TMDB/LoggingLevel/notice``)
    public init(
        apiKey: String,
        urlSessionConfiguration: URLSessionConfiguration = .default,
        minimumLoggingLevel: TMDB.LoggingLevel = .notice,
    ) {
        self.apiKey = apiKey
        self.urlSessionConfiguration = urlSessionConfiguration
        self.minimumLoggingLevel = minimumLoggingLevel
    }
}
