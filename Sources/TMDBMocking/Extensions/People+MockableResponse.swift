import Foundation
import TMDB

extension TMDB.Person: MockableResponse {
    static var mockFilename: String { "PersonDetails" }
}

public extension TMDB.Person {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.PersonMovieCredits: MockableResponse {
    static var mockFilename: String { "PersonMovieCredits" }
}

public extension TMDB.PersonMovieCredits {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.PersonTVCredits: MockableResponse {
    static var mockFilename: String { "PersonTVCredits" }
}

public extension TMDB.PersonTVCredits {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.PersonCombinedCredits: MockableResponse {
    static var mockFilename: String { "PersonCombinedCredits" }
}

public extension TMDB.PersonCombinedCredits {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.PersonImages: MockableResponse {
    static var mockFilename: String { "PersonImages" }
}

public extension TMDB.PersonImages {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.PopularPerson: MockableResponse {
    static var mockFilename: String { "PopularPeople" }
}

public extension TMDB.PopularPerson {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
