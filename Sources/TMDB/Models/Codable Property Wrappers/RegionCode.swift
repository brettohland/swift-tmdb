import Foundation

@propertyWrapper
struct RegionCode: Equatable {
    let wrappedValue: Locale.Region
    init(wrappedValue: Locale.Region) {
        self.wrappedValue = wrappedValue
    }
}

extension RegionCode: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let regionIdentifier = try container.decode(String.self)
        wrappedValue = Locale.Region(regionIdentifier)
    }
}

extension RegionCode: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.identifier)
    }
}
