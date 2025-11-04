import Foundation

public extension TMDBInternal.Movie {
    struct AlternativeTitle: Equatable, Identifiable, Codable {
        public let id: Int
        let titles: [Title]
    }

    struct Title: Equatable, Codable {
        var iso31661: Locale.Region
        let title: String
        let type: String
    }
}
