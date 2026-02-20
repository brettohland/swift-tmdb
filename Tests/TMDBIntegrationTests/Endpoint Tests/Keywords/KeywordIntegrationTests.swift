import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct KeywordIntegrationTests {
    @Test func keywordDetails() async throws {
        try await withLiveTMDB {
            let keyword = try await TMDB.keywordDetails(id: 825)
            #expect(keyword.id == 825)
            #expect(!keyword.name.isEmpty)
        }
    }

    @Test func keywordMovies() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.keywordMovies(id: 825)
            #expect(!results.results.isEmpty)
        }
    }
}
