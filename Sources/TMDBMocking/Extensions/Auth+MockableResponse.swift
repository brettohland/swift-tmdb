import Foundation
import TMDB

extension TMDB.Auth.RequestToken: MockableResponse {
    static var mockFilename: String { "AuthRequestToken" }
}

public extension TMDB.Auth.RequestToken {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Auth.AccessToken: MockableResponse {
    static var mockFilename: String { "AuthAccessToken" }
}

public extension TMDB.Auth.AccessToken {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Auth.V3Session: MockableResponse {
    static var mockFilename: String { "AuthV3Session" }
}

public extension TMDB.Auth.V3Session {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Auth.DeleteResult: MockableResponse {
    static var mockFilename: String { "AuthDeleteResult" }
}

public extension TMDB.Auth.DeleteResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
