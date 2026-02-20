import Foundation

public extension TMDB {
    struct ScreenedTheatricallyResult: Codable, Identifiable, Sendable {
        public let id: Int
        public let seasonNumber: Int
        public let episodeNumber: Int

        public init(id: Int, seasonNumber: Int, episodeNumber: Int) {
            self.id = id
            self.seasonNumber = seasonNumber
            self.episodeNumber = episodeNumber
        }
    }
}

// Internal wrapper for the screened theatrically response
struct ScreenedTheatricallyResponse: Codable {
    let id: Int
    let results: [TMDB.ScreenedTheatricallyResult]
}
