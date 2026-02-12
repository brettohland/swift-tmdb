import Foundation

public extension TMDB {
    struct TranslationCollection: Codable, Identifiable, Sendable {
        public let id: Int
        public let translations: [Translation]
    }

    struct Translation: Codable, Sendable {
        @RegionCode
        public var regionCode: Locale.Region
        @LanguageCode
        public var languageCode: Locale.Language
        public let name: String
        public let englishName: String
        public let data: TranslationData

        enum CodingKeys: String, CodingKey {
            case regionCode = "iso31661"
            case languageCode = "iso6391"
            case name
            case englishName
            case data
        }
    }

    struct TranslationData: Codable, Sendable {
        public let homepage: String?
        public let overview: String?
        public let runtime: Int?
        public let tagline: String?
        public let title: String?
        public let name: String?
    }
}
