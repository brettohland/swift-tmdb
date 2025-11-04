import Foundation

public extension TMDBInternal.Configuration {
    struct CountriesResponse: Codable {
        @RegionArray
        public var countries: [Locale.Region]
    }
}
