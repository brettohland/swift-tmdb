import Foundation
import TMDB

extension TMDB.GenreList: MockableResponse {
    static var mockFilename: String { "MovieGenres" }
}

public extension TMDB.GenreList {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
