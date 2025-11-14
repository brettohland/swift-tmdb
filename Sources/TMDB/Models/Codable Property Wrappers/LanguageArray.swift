import Foundation

/// Decodes/Encodes an array of custom ISO-639:1 values from the TMDB API
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
        let array = try container.decode([LanguageWrapper].self)
        wrappedValue = array.map(\.wrappedValue)
    }
}

extension LanguageArray: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let iso639Array = wrappedValue.map { LanguageWrapper(wrappedValue: $0) }
        try container.encode(iso639Array)
    }
}

/// Decodes/Encodes custom ISO 639:1 objects from the TMDB API into a `Locale.Language` object
@propertyWrapper
public struct LanguageWrapper: Sendable {
    public let wrappedValue: Locale.Language
    public init(wrappedValue: Locale.Language) {
        self.wrappedValue = wrappedValue
    }
}

extension LanguageWrapper: Equatable {}

private extension LanguageWrapper {
    enum DecodingKeys: String, CodingKey {
        case iso639 = "iso6391"
    }

    enum EncodingKeys: String, CodingKey {
        case iso639 = "iso_639_1"
        case name
        case englishName
    }
}

extension LanguageWrapper: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let stringValue = try container.decode(String.self, forKey: .iso639)
        wrappedValue = Locale.Language(identifier: stringValue)
    }
}

extension LanguageWrapper: Encodable {
    private static let enUSLocale = Locale(languageCode: .english, languageRegion: .unitedStates)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        guard
            let languageCode = wrappedValue.languageCode,
            languageCode.isISOLanguage
        else {
            let errorContext = EncodingError.Context(
                codingPath: [],
                debugDescription: "The Locale.Language is not a valid ISO 639-1 language",
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
