import Foundation

@propertyWrapper
public struct RegionCode: Equatable {
    public let wrappedValue: Locale.Region
    public init(wrappedValue: Locale.Region) {
        self.wrappedValue = wrappedValue
    }
}

extension RegionCode: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let regionIdentifier = try container.decode(String.self)
        wrappedValue = Locale.Region(regionIdentifier)
    }
}

extension RegionCode: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.identifier)
    }
}
