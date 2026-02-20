import Foundation
import TMDB

extension TMDB.TrendingResult: MockableResponse {
    static var mockFilename: String { "TrendingAll" }
}

public extension TMDB.TrendingResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.TrendingPerson: MockableResponse {
    static var mockFilename: String { "TrendingPeople" }
}

public extension TMDB.TrendingPerson {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
