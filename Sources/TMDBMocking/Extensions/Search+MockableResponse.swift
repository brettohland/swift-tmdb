import Foundation
import TMDB

extension TMDB.MultiSearchResult: MockableResponse {
    static var mockFilename: String { "SearchMulti" }
}

public extension TMDB.MultiSearchResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.SearchPerson: MockableResponse {
    static var mockFilename: String { "SearchPerson" }
}

public extension TMDB.SearchPerson {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.SearchCollection: MockableResponse {
    static var mockFilename: String { "SearchCollections" }
}

public extension TMDB.SearchCollection {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.SearchCompany: MockableResponse {
    static var mockFilename: String { "SearchCompanies" }
}

public extension TMDB.SearchCompany {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
