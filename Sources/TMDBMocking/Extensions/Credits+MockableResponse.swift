import Foundation
import TMDB

extension TMDB.Credits.Details: MockableResponse {
    static var mockFilename: String { "CreditDetails" }
}

public extension TMDB.Credits.Details {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
