import Foundation
import TMDB

extension TMDB.Collection: MockableResponse {
    static var mockFilename: String { "CollectionDetails" }
}

public extension TMDB.Collection {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
