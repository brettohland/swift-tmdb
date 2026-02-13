import Foundation

public extension TMDB {
    struct TranslationCollection: Codable, Identifiable, Sendable {
        public let id: Int
        public let translations: [Translation]

        public init(id: Int, translations: [Translation]) {
            self.id = id
            self.translations = translations
        }
    }

    struct Translation: Codable, Sendable {
        @RegionCode
        public var regionCode: Locale.Region
        @LanguageCode
        public var languageCode: Locale.Language
        public let name: String
        public let englishName: String
        public let data: TranslationData

        public init(
            regionCode: Locale.Region,
            languageCode: Locale.Language,
            name: String,
            englishName: String,
            data: TranslationData,
        ) {
            _regionCode = RegionCode(wrappedValue: regionCode)
            _languageCode = LanguageCode(wrappedValue: languageCode)
            self.name = name
            self.englishName = englishName
            self.data = data
        }

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

        public init(
            homepage: String?,
            overview: String?,
            runtime: Int?,
            tagline: String?,
            title: String?,
            name: String?,
        ) {
            self.homepage = homepage
            self.overview = overview
            self.runtime = runtime
            self.tagline = tagline
            self.title = title
            self.name = name
        }
    }
}
