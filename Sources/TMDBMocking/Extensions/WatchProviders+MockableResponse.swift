import Foundation
import TMDB

extension TMDB.WatchProviderRegions: MockableResponse {
    static var mockFilename: String { "Regions" }
}

public extension TMDB.WatchProviderRegions {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.WatchProviderList: MockableResponse {
    static var mockFilename: String { "MovieProviders" }
}

public extension TMDB.WatchProviderList {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
