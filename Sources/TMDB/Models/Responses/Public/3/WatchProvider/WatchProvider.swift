import Foundation

public extension TMDB {
    /// Represents a watch provider (streaming service)
    struct WatchProvider: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let logoPath: URL
        public let displayPriority: Int

        public init(id: Int, name: String, logoPath: URL, displayPriority: Int) {
            self.id = id
            self.name = name
            self.logoPath = logoPath
            self.displayPriority = displayPriority
        }

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

        public init(results: [WatchProvider]) {
            self.results = results
        }
    }
}
