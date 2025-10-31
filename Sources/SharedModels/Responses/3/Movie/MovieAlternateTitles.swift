import Foundation

public extension TMDBInternal.Movie {
    struct AlternativeTitle: Equatable, Identifiable, Codable {
        public let id: Int
        let titles: [Title]
    }

    struct Title: Equatable, Codable {
        @ISO31661RegionIdentifier
        var iso31661: Locale.Region
        let title: String
        let type: String
    }
}

//extension TMDBInternal.Movie.AlternativeTitle.Title: Codable {
//    enum CodingKeys: String, CodingKey {
//        case id
//        case titles
//    }
//}
