import Foundation

@propertyWrapper
struct LanguageCode {
    let wrappedValue: Locale.Language
    init(wrappedValue: Locale.Language) {
        self.wrappedValue = wrappedValue
    }
}

extension LanguageCode: Equatable {}

extension LanguageCode: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        wrappedValue = Locale.Language(identifier: stringValue)
    }
}

extension LanguageCode: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard let languageCode = wrappedValue.languageCode else {
            throw EncodingError.invalidValue(
                wrappedValue,
                EncodingError.Context(codingPath: [], debugDescription: "Invalid Locale.Language"),
            )
        }
        try container.encode(languageCode)
    }
}
