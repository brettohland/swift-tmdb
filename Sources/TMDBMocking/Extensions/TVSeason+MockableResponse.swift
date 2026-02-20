import Foundation
import TMDB

extension TMDB.TVSeason: MockableResponse {
    static var mockFilename: String { "TVSeasonDetails" }
}

public extension TMDB.TVSeason {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
