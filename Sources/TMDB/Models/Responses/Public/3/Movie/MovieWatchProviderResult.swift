import Foundation

public extension TMDB {
    struct MovieWatchProviderResult: Codable, Identifiable, Sendable {
        public let id: Int
        public let results: [String: WatchProviderAvailability]
    }

    struct WatchProviderAvailability: Codable, Sendable {
        public let link: String?
        public let flatrate: [WatchProvider]?
        public let rent: [WatchProvider]?
        public let buy: [WatchProvider]?
    }
}
