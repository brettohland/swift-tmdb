import Dependencies
import Foundation
import Testing
@testable import TMDB

struct KeywordEndpointTests {
    @Test func keywordDetails() async throws {
        let keyword = try await TMDB.keywordDetails(id: 825)
        #expect(!keyword.name.isEmpty)
    }

    @Test func keywordMovies() async throws {
        let results = try await TMDB.keywordMovies(id: 825)
        #expect(!results.results.isEmpty)
    }
}
