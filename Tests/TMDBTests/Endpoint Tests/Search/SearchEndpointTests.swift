import Dependencies
import Foundation
import Testing
@testable import TMDB

struct SearchEndpointTests {
    @Test func searchMovies() async throws {
        let results = try await TMDB.searchMovies(query: "Fight Club")
        #expect(!results.results.isEmpty)
    }

    @Test func searchTV() async throws {
        let results = try await TMDB.searchTV(query: "Breaking Bad")
        #expect(!results.results.isEmpty)
    }

    @Test func searchPeople() async throws {
        let results = try await TMDB.searchPeople(query: "Brad Pitt")
        #expect(!results.results.isEmpty)
    }

    @Test func searchMulti() async throws {
        let results = try await TMDB.searchMulti(query: "Fight Club")
        #expect(!results.results.isEmpty)
    }

    @Test func searchCollections() async throws {
        let results = try await TMDB.searchCollections(query: "Shrek")
        #expect(!results.results.isEmpty)
    }

    @Test func searchCompanies() async throws {
        let results = try await TMDB.searchCompanies(query: "Lucasfilm")
        #expect(!results.results.isEmpty)
    }

    @Test func searchKeywords() async throws {
        let results = try await TMDB.searchKeywords(query: "support group")
        #expect(!results.results.isEmpty)
    }
}
