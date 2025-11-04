import Foundation

@propertyWrapper
public struct LanguageArray: Sendable {
    public let wrappedValue: [Locale.Language]
    public init(wrappedValue: [Locale.Language]) {
        self.wrappedValue = wrappedValue
    }
}

extension LanguageArray: Equatable {}

extension LanguageArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([Language].self)
        wrappedValue = array.map(\.wrappedValue)
    }
}

extension LanguageArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let iso639Array = wrappedValue.map { Language(wrappedValue: $0) }
        try container.encode(iso639Array)
    }
}
