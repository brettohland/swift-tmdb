import Foundation

public extension TMDB {
    struct TVSeason: Codable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: URL?
        @ISO8601YMD
        public var airDate: Date?
        public let seasonNumber: Int
        public let voteAverage: Double
        public let episodes: [TVEpisode]

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overview
            case posterPath
            case airDate
            case seasonNumber
            case voteAverage
            case episodes
        }
    }
}
