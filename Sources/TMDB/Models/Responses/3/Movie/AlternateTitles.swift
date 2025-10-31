import Foundation

public extension TMDB.Movie {
    struct AlternateTitles: Equatable, Identifiable {
        public let id: Int
        let titles: [Title]
    }

    struct Title: Equatable {
        @ISO3166Region
        var iso3166Code: Locale.Region
        let title: String
        let type: String
    }
}
