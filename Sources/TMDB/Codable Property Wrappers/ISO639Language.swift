import Foundation

@propertyWrapper
public struct ISO639Language {
    public let wrappedValue: Locale.Language
    public init(wrappedValue: Locale.Language) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO639Language: Equatable {}

private extension ISO639Language {
    enum DecodingKeys: String, CodingKey {
        case iso639 = "iso6391"
    }

    enum EncodingKeys: String, CodingKey {
        case iso639 = "iso_639_1"
        case name
        case englishName
    }
}

extension ISO639Language: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let stringValue = try container.decode(String.self, forKey: .iso639)
        wrappedValue = Locale.Language(identifier: stringValue)
    }
}

extension ISO639Language: Encodable {
    private static let enUSLocale = Locale(languageCode: .english, languageRegion: .unitedStates)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        guard
            let languageCode = wrappedValue.languageCode,
            languageCode.isISOLanguage
        else {
            let errorContext = EncodingError.Context(
                codingPath: [],
                debugDescription: "The Locale.Language is not a valid ISO 639-1 language"
            )
            throw EncodingError.invalidValue(wrappedValue, errorContext)
        }
        let englishName = Self.enUSLocale.localizedString(forLanguageCode: languageCode.identifier)
        let localizedName = Locale.current.localizedString(forLanguageCode: languageCode.identifier)
        try container.encode(englishName, forKey: .englishName)
        try container.encode(localizedName, forKey: .name)
        try container.encode(languageCode.identifier, forKey: .iso639)
    }
}
