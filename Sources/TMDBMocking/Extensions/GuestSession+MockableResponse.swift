import Foundation
import TMDB

extension TMDB.Auth.GuestSession: MockableResponse {
    static var mockFilename: String { "AuthGuestSession" }
}

public extension TMDB.Auth.GuestSession {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.GuestSession.RatedMovie: MockableResponse {
    static var mockFilename: String { "GuestRatedMovie" }
}

public extension TMDB.GuestSession.RatedMovie {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.GuestSession.RatedTV: MockableResponse {
    static var mockFilename: String { "GuestRatedTVShow" }
}

public extension TMDB.GuestSession.RatedTV {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.GuestSession.RatedEpisode: MockableResponse {
    static var mockFilename: String { "GuestRatedEpisode" }
}

public extension TMDB.GuestSession.RatedEpisode {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
