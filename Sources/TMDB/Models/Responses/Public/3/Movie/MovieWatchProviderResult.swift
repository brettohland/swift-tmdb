import Foundation

public extension TMDB {
    struct MediaWatchProviderResult: Codable, Identifiable, Sendable {
        public let id: Int
        public let results: [String: WatchProviderAvailability]

        public init(id: Int, results: [String: WatchProviderAvailability]) {
            self.id = id
            self.results = results
        }
    }

    struct WatchProviderAvailability: Codable, Sendable {
        public let link: String?
        public let flatrate: [WatchProvider]?
        public let rent: [WatchProvider]?
        public let buy: [WatchProvider]?

        public init(link: String?, flatrate: [WatchProvider]?, rent: [WatchProvider]?, buy: [WatchProvider]?) {
            self.link = link
            self.flatrate = flatrate
            self.rent = rent
            self.buy = buy
        }
    }
}
