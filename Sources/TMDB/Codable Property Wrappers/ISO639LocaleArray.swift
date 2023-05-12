import Foundation

@propertyWrapper
public struct ISO639LocaleArray {
    public let wrappedValue: [Locale]
    public init(wrappedValue: [Locale]) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO639LocaleArray: Equatable {}

extension ISO639LocaleArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([ISO639Locale].self)
        wrappedValue = array.map { Locale(identifier: $0.wrappedValue.identifier) }
    }
}

extension ISO639LocaleArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let iso639Array = wrappedValue.map { ISO639Locale(wrappedValue: $0) }
        try container.encode(iso639Array)
    }
}
