import Foundation

public struct TMDBConfiguration: Sendable {
    public let apiKey: String
    public let urlSessionConfiguration: URLSessionConfiguration
    public let minimumLoggingLevel: TMDB.LoggingLevel

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
