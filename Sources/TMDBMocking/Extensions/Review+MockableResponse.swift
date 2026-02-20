import Foundation
import TMDB

extension TMDB.Review: MockableResponse {
    static var mockFilename: String { "ReviewDetails" }
}

public extension TMDB.Review {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
