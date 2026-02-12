import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct KeywordEndpointTests {
    init() { TMDBMockData.register() }
    @Test func keywordDetails() async throws {
        let keyword = try await TMDB.keywordDetails(id: 825)
        #expect(!keyword.name.isEmpty)
    }

    @Test func keywordMovies() async throws {
        let results = try await TMDB.keywordMovies(id: 825)
        #expect(!results.results.isEmpty)
    }
}
