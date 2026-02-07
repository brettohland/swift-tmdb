import Foundation

public extension TMDB {
    /// Represents a region where watch providers are available
    struct WatchProviderRegion: Codable, Sendable {
        @RegionCode public var iso31661: Locale.Region
        public let englishName: String
        public let nativeName: String
    }

    /// Response for watch provider regions
    struct WatchProviderRegions: Codable, Sendable {
        public let results: [WatchProviderRegion]
    }
}
