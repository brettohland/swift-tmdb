import Foundation

public struct TMDBConfiguration: Sendable {
    public let apiKey: String
    public let urlSessionConfiguration: URLSessionConfiguration

    public init(
        apiKey: String,
        urlSessionConfiguration: URLSessionConfiguration = .default,
    ) {
        self.apiKey = apiKey
        self.urlSessionConfiguration = urlSessionConfiguration
    }
}
