import Foundation
import TMDB

extension TMDB.MovieCertifications: MockableResponse {
    static var mockFilename: String { "MovieCertifications" }
}

public extension TMDB.MovieCertifications {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.TVCertifications: MockableResponse {
    static var mockFilename: String { "TVCertifications" }
}

public extension TMDB.TVCertifications {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
