import Foundation

public extension TMDB.Configuration {
    /// Represents a timezone group from the `/3/configuration/timezones` endpoint
    ///
    /// [Details on TMDB's site](https://developer.themoviedb.org/reference/configuration-timezones)
    struct Timezone: Codable, Sendable {
        @RegionCode public var regionCode: Locale.Region
        public let zones: [String]

        public init(regionCode: Locale.Region, zones: [String]) {
            _regionCode = RegionCode(wrappedValue: regionCode)
            self.zones = zones
        }

        enum CodingKeys: String, CodingKey {
            case regionCode = "iso31661"
            case zones
        }
    }
}
