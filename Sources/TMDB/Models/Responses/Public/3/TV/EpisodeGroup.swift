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
    }
}

// Internal wrapper for the episode groups response
struct EpisodeGroupsResponse: Codable {
    let id: Int
    let results: [TMDB.EpisodeGroup]
}
