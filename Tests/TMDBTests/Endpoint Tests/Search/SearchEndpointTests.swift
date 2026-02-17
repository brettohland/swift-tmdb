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

    // MARK: - URL Generation Tests

    @Test func searchMovieURLWithAllParams() {
        let endpoint = TMDB.V3Endpoints.Search.movie(
            query: "Fight Club",
            page: 2,
            includeAdult: true,
            year: 1_999,
            primaryReleaseYear: 1_999,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        #expect(url.relativePath == "/3/search/movie")
        #expect(components.queryItems?.contains(where: { $0.name == "query" && $0.value == "Fight Club" }) == true)
        #expect(components.queryItems?.contains(where: { $0.name == "page" && $0.value == "2" }) == true)
        #expect(components.queryItems?.contains(where: { $0.name == "include_adult" && $0.value == "true" }) == true)
        #expect(components.queryItems?.contains(where: { $0.name == "year" && $0.value == "1999" }) == true)
        #expect(components.queryItems?
            .contains(where: { $0.name == "primary_release_year" && $0.value == "1999" }) == true)
    }

    @Test func searchMovieURLWithDefaults() {
        let endpoint = TMDB.V3Endpoints.Search.movie(
            query: "Fight Club",
            page: 1,
            includeAdult: false,
            year: nil,
            primaryReleaseYear: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        #expect(components.queryItems?.contains(where: { $0.name == "include_adult" }) != true)
        #expect(components.queryItems?.contains(where: { $0.name == "year" }) != true)
        #expect(components.queryItems?.contains(where: { $0.name == "primary_release_year" }) != true)
    }

    @Test func searchTVURLWithAllParams() {
        let endpoint = TMDB.V3Endpoints.Search.tv(
            query: "Breaking Bad",
            page: 1,
            includeAdult: true,
            firstAirDateYear: 2_008,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        #expect(url.relativePath == "/3/search/tv")
        #expect(components.queryItems?.contains(where: { $0.name == "include_adult" && $0.value == "true" }) == true)
        #expect(components.queryItems?
            .contains(where: { $0.name == "first_air_date_year" && $0.value == "2008" }) == true)
    }

    @Test func searchTVURLWithDefaults() {
        let endpoint = TMDB.V3Endpoints.Search.tv(
            query: "Breaking Bad",
            page: 1,
            includeAdult: false,
            firstAirDateYear: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        #expect(components.queryItems?.contains(where: { $0.name == "include_adult" }) != true)
        #expect(components.queryItems?.contains(where: { $0.name == "first_air_date_year" }) != true)
    }

    @Test func searchPersonURLWithIncludeAdult() {
        let endpoint = TMDB.V3Endpoints.Search.person(
            query: "Brad Pitt",
            page: 1,
            includeAdult: true,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        #expect(url.relativePath == "/3/search/person")
        #expect(components.queryItems?.contains(where: { $0.name == "include_adult" && $0.value == "true" }) == true)
    }

    @Test func searchMultiURLWithIncludeAdult() {
        let endpoint = TMDB.V3Endpoints.Search.multi(
            query: "Fight Club",
            page: 1,
            includeAdult: true,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        #expect(url.relativePath == "/3/search/multi")
        #expect(components.queryItems?.contains(where: { $0.name == "include_adult" && $0.value == "true" }) == true)
    }
}
