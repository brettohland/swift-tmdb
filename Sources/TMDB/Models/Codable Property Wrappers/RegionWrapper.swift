import Foundation

@propertyWrapper
struct RegionWrapper: Equatable {
    let wrappedValue: Locale.Region
    init(wrappedValue: Locale.Region) {
        self.wrappedValue = wrappedValue
    }
}

private extension RegionWrapper {
    enum CodingKeys: String, CodingKey {
//        case iso3166 = "iso_3166_1"
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
