import Foundation

public extension TMDBInternal.Configuration {
    struct CountriesResponse {
        public var countries: [Locale.Region]
    }
}

extension TMDBInternal.Configuration.CountriesResponse: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedWrappers = try container.decode([RegionWrapper].self)
        countries = decodedWrappers.map(\.wrappedValue)
    }
}

extension TMDBInternal.Configuration.CountriesResponse: Encodable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let encodedWrappers = countries.map {
            RegionWrapper(wrappedValue: $0)
        }
        try container.encode(encodedWrappers)
    }
}
