import Foundation

@propertyWrapper
struct ISO639LocaleString {
    let wrappedValue: Locale
    init(wrappedValue: Locale) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO639LocaleString: Equatable {}

extension ISO639LocaleString: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        wrappedValue = Locale(identifier: stringValue)
    }
}

extension ISO639LocaleString: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let localizedIdentifier = Locale.autoupdatingCurrent.localizedString(forIdentifier: wrappedValue.identifier)
        try container.encode(localizedIdentifier)
    }
}
