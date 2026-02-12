import Foundation

extension TMDB.TVEpisode: MockableResponse {
    static var mockFilename: String {
        "TVEpisodeDetails"
    }
}

extension TMDB.EpisodeGroupDetails: MockableResponse {
    static var mockFilename: String {
        "EpisodeGroupDetails"
    }
}
