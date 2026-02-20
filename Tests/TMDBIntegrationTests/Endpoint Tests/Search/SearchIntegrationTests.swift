import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct SearchIntegrationTests {
    @Test func searchMovies() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.searchMovies(query: "Fight Club")
            #expect(!results.results.isEmpty)
            #expect(results.results.contains { $0.id == 550 })
        }
    }

    @Test func searchTV() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.searchTV(query: "Breaking Bad")
            #expect(!results.results.isEmpty)
            #expect(results.results.contains { $0.id == 1_396 })
        }
    }

    @Test func searchPeople() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.searchPeople(query: "Brad Pitt")
            #expect(!results.results.isEmpty)
            #expect(results.results.contains { $0.id == 287 })
        }
    }

    @Test func searchMulti() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.searchMulti(query: "Fight Club")
            #expect(!results.results.isEmpty)
        }
    }

    @Test func searchCollections() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.searchCollections(query: "Shrek")
            #expect(!results.results.isEmpty)
        }
    }

    @Test func searchCompanies() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.searchCompanies(query: "Lucasfilm")
            #expect(!results.results.isEmpty)
        }
    }

    @Test func searchKeywords() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.searchKeywords(query: "support group")
            #expect(!results.results.isEmpty)
        }
    }
}
