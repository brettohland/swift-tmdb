import Foundation

public extension TMDB.Configuration {
    /// Represents a language from the `/3/configuration/languages` endpoint
    ///
    /// [Details on TMDB's site](https://developer.themoviedb.org/reference/configuration-languages)
    struct Language: Codable, Sendable {
        @LanguageCode public var languageCode: Locale.Language
        public let englishName: String
        public let name: String

        enum CodingKeys: String, CodingKey {
            case languageCode = "iso6391"
            case englishName
            case name
        }
    }
}
