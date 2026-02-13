import Foundation

public extension TMDB {
    struct EpisodeGroup: Codable, Identifiable, Sendable {
        public let id: String
        public let name: String
        public let description: String
        public let episodeCount: Int
        public let groupCount: Int
        public let type: Int
        public let network: TVSeries.Network?

        public init(
            id: String,
            name: String,
            description: String,
            episodeCount: Int,
            groupCount: Int,
            type: Int,
            network: TVSeries.Network?,
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.episodeCount = episodeCount
            self.groupCount = groupCount
            self.type = type
            self.network = network
        }
    }
}

// Internal wrapper for the episode groups response
struct EpisodeGroupsResponse: Codable {
    let id: Int
    let results: [TMDB.EpisodeGroup]
}
