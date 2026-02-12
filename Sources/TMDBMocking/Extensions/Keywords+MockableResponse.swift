import Foundation
import TMDB

extension TMDB.Keyword: MockableResponse {
    static var mockFilename: String { "KeywordDetails" }
}

public extension TMDB.Keyword {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
