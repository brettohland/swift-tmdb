import Foundation
import TMDB

extension TMDB.Network: MockableResponse {
    static var mockFilename: String { "NetworkDetails" }
}

public extension TMDB.Network {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
