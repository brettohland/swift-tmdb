import Foundation
import TMDB

extension TMDB.Account.WriteResult: MockableResponse {
    static var mockFilename: String { "AccountWriteResult" }
}

public extension TMDB.Account.WriteResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
