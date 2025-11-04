import Foundation

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
