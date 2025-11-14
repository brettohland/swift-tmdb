import Foundation

/// Decodes/Encodes an array of TMDB ISO-3611:1 objects as an array of `Locale.Region` values.
@propertyWrapper
public struct RegionArray: Sendable {
    public let wrappedValue: [Locale.Region]
    public init(wrappedValue: [Locale.Region]) {
        self.wrappedValue = wrappedValue
    }
}

extension RegionArray: Equatable {}

extension RegionArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([RegionWrapper].self)
        wrappedValue = array.map(\.wrappedValue)
    }
}

extension RegionArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let rawArray = wrappedValue.compactMap { RegionWrapper(wrappedValue: $0) }
        try container.encode(rawArray)
    }
}

/// Encodes/Decodes the custom ISO 3166:1 region objects into a `Locale.Region` value
@propertyWrapper
struct RegionWrapper: Equatable {
    let wrappedValue: Locale.Region
    init(wrappedValue: Locale.Region) {
        self.wrappedValue = wrappedValue
    }
}

private extension RegionWrapper {
    enum CodingKeys: String, CodingKey {
        case iso3166 = "iso31661"
        case name
    }
}

extension RegionWrapper: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let regionIdentifier = try container.decode(String.self, forKey: .iso3166)
        let region = Locale.Region(regionIdentifier)
        wrappedValue = region
    }
}

extension RegionWrapper: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wrappedValue.identifier, forKey: .iso3166)
        let currentRegionName = Locale.autoupdatingCurrent.localizedString(forRegionCode: wrappedValue.identifier)
        try container.encode(currentRegionName, forKey: .name)
    }
}
