import Foundation

public extension TMDB {
    /// Represents a region where watch providers are available
    struct WatchProviderRegion: Codable, Sendable {
        @RegionCode public var regionCode: Locale.Region
        public let englishName: String
        public let nativeName: String

        enum CodingKeys: String, CodingKey {
            case regionCode = "iso31661"
            case englishName
            case nativeName
        }
    }

    /// Response for watch provider regions
    struct WatchProviderRegions: Codable, Sendable {
        public let results: [WatchProviderRegion]
    }
}
