import Foundation
import TMDB

extension TMDB.Company: MockableResponse {
    static var mockFilename: String { "CompanyDetails" }
}

public extension TMDB.Company {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.LogoCollection: MockableResponse {
    static var mockFilename: String { "CompanyImages" }
}

public extension TMDB.LogoCollection {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
