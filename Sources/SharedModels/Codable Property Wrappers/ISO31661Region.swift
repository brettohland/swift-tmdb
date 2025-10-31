import Foundation

@propertyWrapper
public struct ISO31661RegionIdentifier: Equatable {
    public let wrappedValue: Locale.Region
    public init(wrappedValue: Locale.Region) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO31661RegionIdentifier: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let regionIdentifier = try container.decode(String.self)
        wrappedValue = Locale.Region(regionIdentifier)
    }
}

extension ISO31661RegionIdentifier: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.identifier)
    }
}
