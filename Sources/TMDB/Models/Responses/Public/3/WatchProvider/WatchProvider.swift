import Foundation

public extension TMDB {
    /// Represents a watch provider (streaming service)
    struct WatchProvider: Codable, Sendable {
        public let providerId: Int
        public let providerName: String
        public let logoPath: String
        public let displayPriority: Int
    }

    /// Response for watch provider lists
    struct WatchProviderList: Codable, Sendable {
        public let results: [WatchProvider]
    }
}
