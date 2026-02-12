import Foundation

public extension TMDB {
    struct EpisodeGroupDetails: Codable, Identifiable, Sendable {
        public let id: String
        public let name: String
        public let description: String
        public let episodeCount: Int
        public let groupCount: Int
        public let type: Int
        public let network: TVSeries.Network?
        public let groups: [Group]

        public struct Group: Codable, Identifiable, Sendable {
            public let id: String
            public let name: String
            public let order: Int
            public let episodes: [TVEpisode]
        }
    }
}
