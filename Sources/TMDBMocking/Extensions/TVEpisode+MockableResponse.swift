import Foundation
import TMDB

extension TMDB.TVEpisode: MockableResponse {
    static var mockFilename: String { "TVEpisodeDetails" }
}

public extension TMDB.TVEpisode {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.EpisodeGroupDetails: MockableResponse {
    static var mockFilename: String { "EpisodeGroupDetails" }
}

public extension TMDB.EpisodeGroupDetails {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
