import Foundation

@propertyWrapper
public struct ISO3166Region: Equatable {
    public let wrappedValue: Locale.Region
    public init(wrappedValue: Locale.Region) {
        self.wrappedValue = wrappedValue
    }
}

private extension ISO3166Region {
    enum DecodingKeys: String, CodingKey {
        case iso3166 = "iso31661"
    }

    enum EncodingKeys: String, CodingKey {
        case iso3166 = "iso_3166_1"
        case name
    }
}

extension ISO3166Region: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let regionIdentifier = try container.decode(String.self, forKey: .iso3166)
        let region = Locale.Region(regionIdentifier)
        wrappedValue = region
    }
}

extension ISO3166Region: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode(wrappedValue.identifier, forKey: .iso3166)
        let currentRegionName = Locale.autoupdatingCurrent.localizedString(forRegionCode: wrappedValue.identifier)
        try container.encode(currentRegionName, forKey: .name)
    }
}
