import Foundation

@propertyWrapper
public struct ISO3611RegionArray {
    public let wrappedValue: [Locale.Region]
    public init(wrappedValue: [Locale.Region]) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO3611RegionArray: Equatable {}

extension ISO3611RegionArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([ISO3166Region].self)
        wrappedValue = array.map(\.wrappedValue)
    }
}

extension ISO3611RegionArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let rawArray = wrappedValue.compactMap { ISO3166Region(wrappedValue: $0) }
        try container.encode(rawArray)
    }
}
