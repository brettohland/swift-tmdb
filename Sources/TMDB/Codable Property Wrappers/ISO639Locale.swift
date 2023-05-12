import Foundation

@propertyWrapper
public struct ISO639Locale {
    public let wrappedValue: Locale
    public init(wrappedValue: Locale) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO639Locale: Equatable {}

private extension ISO639Locale {
    enum DecodingKeys: String, CodingKey {
        case iso639 = "iso6391"
    }

    enum EncodingKeys: String, CodingKey {
        case iso639 = "iso_639_1"
        case name
        case englishName
    }
}

extension ISO639Locale: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let stringValue = try container.decode(String.self, forKey: .iso639)
        wrappedValue = Locale(identifier: stringValue)
    }
}

extension ISO639Locale: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        let localizedIdentifier = Locale.autoupdatingCurrent.localizedString(forIdentifier: wrappedValue.identifier)
        try container.encode(localizedIdentifier, forKey: .name)
        try container.encode(wrappedValue.identifier, forKey: .iso639)
        let englishName = Locale(identifier: "en").localizedString(forIdentifier: wrappedValue.identifier)
        try container.encode(englishName, forKey: .englishName)
    }
}
