import Foundation
import TMDB

extension TMDB.List.Details: MockableResponse {
    static var mockFilename: String { "ListDetails" }
}

public extension TMDB.List.Details {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.List.ItemStatus: MockableResponse {
    static var mockFilename: String { "ListItemStatus" }
}

public extension TMDB.List.ItemStatus {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.List.CreateResult: MockableResponse {
    static var mockFilename: String { "ListCreateResult" }
}

public extension TMDB.List.CreateResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.List.ItemsResult: MockableResponse {
    static var mockFilename: String { "ListItemsResult" }
}

public extension TMDB.List.ItemsResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
