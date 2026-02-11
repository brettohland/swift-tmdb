import Foundation

public extension TMDB {
    /// Represents a watch provider (streaming service)
    struct WatchProvider: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let logoPath: URL
        public let displayPriority: Int

        enum CodingKeys: String, CodingKey {
            case id = "providerId"
            case name = "providerName"
            case logoPath
            case displayPriority
        }
    }

    /// Response for watch provider lists
    struct WatchProviderList: Codable, Sendable {
        public let results: [WatchProvider]
    }
}
