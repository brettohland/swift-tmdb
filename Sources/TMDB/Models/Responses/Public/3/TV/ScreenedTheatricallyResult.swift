import Foundation

public extension TMDB {
    struct ScreenedTheatricallyResult: Codable, Identifiable, Sendable {
        public let id: Int
        public let seasonNumber: Int
        public let episodeNumber: Int
    }
}

// Internal wrapper for the screened theatrically response
struct ScreenedTheatricallyResponse: Codable {
    let id: Int
    let results: [TMDB.ScreenedTheatricallyResult]
}
