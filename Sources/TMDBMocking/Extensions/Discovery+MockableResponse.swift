import Foundation
import TMDB

extension TMDB.Discover.DiscoverMovie: MockableResponse {
    static var mockFilename: String { "DiscoverMovie" }
}

public extension TMDB.Discover.DiscoverMovie {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Discover.DiscoverTV: MockableResponse {
    static var mockFilename: String { "DiscoverTV" }
}

public extension TMDB.Discover.DiscoverTV {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
