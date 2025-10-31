import Foundation

@propertyWrapper
public struct ISO639LanguageArray: Sendable {
    public let wrappedValue: [Locale.Language]
    public init(wrappedValue: [Locale.Language]) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO639LanguageArray: Equatable {}

extension ISO639LanguageArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([ISO639Language].self)
        wrappedValue = array.map(\.wrappedValue)
    }
}

extension ISO639LanguageArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let iso639Array = wrappedValue.map { ISO639Language(wrappedValue: $0) }
        try container.encode(iso639Array)
    }
}
