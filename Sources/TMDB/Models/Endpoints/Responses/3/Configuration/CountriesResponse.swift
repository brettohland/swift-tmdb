import Foundation

extension TMDB.Configuration {
    struct CountriesResponse {
        var countries: [Locale.Region]
    }
}

extension TMDB.Configuration.CountriesResponse: Decodable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedWrappers = try container.decode([RegionWrapper].self)
        countries = decodedWrappers.map(\.wrappedValue)
    }
}

extension TMDB.Configuration.CountriesResponse: Encodable {
    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let encodedWrappers = countries.map {
            RegionWrapper(wrappedValue: $0)
        }
        try container.encode(encodedWrappers)
    }
}
