import Foundation
import TMDB

extension TMDB.AlternativeTitle: MockableResponse {
    static var mockFilename: String { "AlternativeTitles" }
}

public extension TMDB.AlternativeTitle {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.Movie: MockableResponse {
    static var mockFilename: String { "MovieDetails" }
}

public extension TMDB.Movie {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.MediaCredits: MockableResponse {
    static var mockFilename: String { "MovieCredits" }
}

public extension TMDB.MediaCredits {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.ImageCollection: MockableResponse {
    static var mockFilename: String { "MovieImages" }
}

public extension TMDB.ImageCollection {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.VideoCollection: MockableResponse {
    static var mockFilename: String { "MovieVideos" }
}

public extension TMDB.VideoCollection {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.ExternalIDs: MockableResponse {
    static var mockFilename: String { "MovieExternalIDs" }
}

public extension TMDB.ExternalIDs {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.MediaWatchProviderResult: MockableResponse {
    static var mockFilename: String { "MovieWatchProviders" }
}

public extension TMDB.MediaWatchProviderResult {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.ChangeCollection: MockableResponse {
    static var mockFilename: String { "MovieChanges" }
}

public extension TMDB.ChangeCollection {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.TranslationCollection: MockableResponse {
    static var mockFilename: String { "MovieTranslations" }
}

public extension TMDB.TranslationCollection {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
