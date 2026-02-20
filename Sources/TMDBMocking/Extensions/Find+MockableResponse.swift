import Foundation
import TMDB

extension TMDB.FindResult: MockableResponse {
    static var mockFilename: String { "FindByID" }
}

public extension TMDB.FindResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
