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

        public init(
            id: String,
            name: String,
            description: String,
            episodeCount: Int,
            groupCount: Int,
            type: Int,
            network: TVSeries.Network?,
            groups: [Group],
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.episodeCount = episodeCount
            self.groupCount = groupCount
            self.type = type
            self.network = network
            self.groups = groups
        }

        public struct Group: Codable, Identifiable, Sendable {
            public let id: String
            public let name: String
            public let order: Int
            public let episodes: [TVEpisode]

            public init(id: String, name: String, order: Int, episodes: [TVEpisode]) {
                self.id = id
                self.name = name
                self.order = order
                self.episodes = episodes
            }
        }
    }
}
