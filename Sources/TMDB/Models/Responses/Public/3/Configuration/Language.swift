import Foundation

public extension TMDB.Configuration {
    /// Represents a language from the `/3/configuration/languages` endpoint
    ///
    /// [Details on TMDB's site](https://developer.themoviedb.org/reference/configuration-languages)
    struct Language: Codable, Sendable {
        @LanguageCode public var iso6391: Locale.Language
        public let englishName: String
        public let name: String
    }
}
