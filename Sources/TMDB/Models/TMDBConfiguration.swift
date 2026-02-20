import Foundation

/// A configuration struct used by the package to configure itself.
public struct TMDBConfiguration: Sendable {
    /// Your TMDB API Key
    public let apiKey: String
    /// An optional configuration for all URLSessions internally to the module to use in all requests
    public let urlSessionConfiguration: URLSessionConfiguration
    /// The minimum logging level to use when outputting logs to OSLog
    public let minimumLoggingLevel: TMDB.LoggingLevel
    /// An optional default language to include on all supporting requests
    public let defaultLanguage: Locale?
    /// An optional default region to include on all supporting requests
    public let defaultRegion: Locale.Region?

    /// Initialize a new TMDBConfiguration struct
    /// - Parameters:
    ///   - apiKey: Your TMDB API Key
    ///   - urlSessionConfiguration: An optional configuration for all URLSessions internally to the module to use in
    ///   all requests (Defaults to `.default`)
    ///   - minimumLoggingLevel: The minimum logging level to use when outputting logs to OSLog (Defaults
    ///   to ``TMDB/LoggingLevel/notice``)
    ///   - defaultLanguage: An optional default language to include on all supporting requests (Defaults to `nil`)
    ///   - defaultRegion: An optional default region to include on all supporting requests (Defaults to `nil`)
    public init(
        apiKey: String,
        urlSessionConfiguration: URLSessionConfiguration = .default,
        minimumLoggingLevel: TMDB.LoggingLevel = .notice,
        defaultLanguage: Locale? = nil,
        defaultRegion: Locale.Region? = nil,
    ) {
        self.apiKey = apiKey
        self.urlSessionConfiguration = urlSessionConfiguration
        self.minimumLoggingLevel = minimumLoggingLevel
        self.defaultLanguage = defaultLanguage
        self.defaultRegion = defaultRegion
    }
}
