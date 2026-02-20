import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

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

    // MARK: - URL Generation Tests

    @Test func searchMovieURLWithAllParams() {
        let endpoint = TMDB.V3Endpoints.Search.movie(
            query: "Fight Club",
            page: 2,
            includeAdult: true,
            year: 1_999,
            primaryReleaseYear: 1_999,
            language: nil,
            region: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems!
        #expect(url.relativePath == "/3/search/movie")
        #expect(queryItems.contains { $0.name == "query" && $0.value == "Fight Club" })
        #expect(queryItems.contains { $0.name == "page" && $0.value == "2" })
        #expect(queryItems.contains { $0.name == "include_adult" && $0.value == "true" })
        #expect(queryItems.contains { $0.name == "year" && $0.value == "1999" })
        #expect(queryItems.contains { $0.name == "primary_release_year" && $0.value == "1999" })
    }

    @Test func searchMovieURLWithDefaults() {
        let endpoint = TMDB.V3Endpoints.Search.movie(
            query: "Fight Club",
            page: 1,
            includeAdult: false,
            year: nil,
            primaryReleaseYear: nil,
            language: nil,
            region: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems ?? []
        #expect(!queryItems.contains { $0.name == "include_adult" })
        #expect(!queryItems.contains { $0.name == "year" })
        #expect(!queryItems.contains { $0.name == "primary_release_year" })
    }

    @Test func searchTVURLWithAllParams() {
        let endpoint = TMDB.V3Endpoints.Search.tv(
            query: "Breaking Bad",
            page: 1,
            includeAdult: true,
            firstAirDateYear: 2_008,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems!
        #expect(url.relativePath == "/3/search/tv")
        #expect(queryItems.contains { $0.name == "include_adult" && $0.value == "true" })
        #expect(queryItems.contains { $0.name == "first_air_date_year" && $0.value == "2008" })
    }

    @Test func searchTVURLWithDefaults() {
        let endpoint = TMDB.V3Endpoints.Search.tv(
            query: "Breaking Bad",
            page: 1,
            includeAdult: false,
            firstAirDateYear: nil,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems ?? []
        #expect(!queryItems.contains { $0.name == "include_adult" })
        #expect(!queryItems.contains { $0.name == "first_air_date_year" })
    }

    @Test func searchPersonURLWithIncludeAdult() {
        let endpoint = TMDB.V3Endpoints.Search.person(
            query: "Brad Pitt",
            page: 1,
            includeAdult: true,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems!
        #expect(url.relativePath == "/3/search/person")
        #expect(queryItems.contains { $0.name == "include_adult" && $0.value == "true" })
    }

    @Test func searchMultiURLWithIncludeAdult() {
        let endpoint = TMDB.V3Endpoints.Search.multi(
            query: "Fight Club",
            page: 1,
            includeAdult: true,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems!
        #expect(url.relativePath == "/3/search/multi")
        #expect(queryItems.contains { $0.name == "include_adult" && $0.value == "true" })
    }
}
