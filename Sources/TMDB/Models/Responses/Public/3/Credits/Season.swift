import Foundation

public extension TMDB.Credits {
    struct Season: Codable, Identifiable, Sendable {
        @ISO8601YMD
        public var airDate: Date?
        public let episodeCount: Int
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: URL
        public let seasonNumber: Int
        public let showID: Int

        enum CodingKeys: String, CodingKey {
            case airDate
            case episodeCount
            case id
            case name
            case overview
            case posterPath
            case seasonNumber
            case showID = "showId"
        }
    }
}
