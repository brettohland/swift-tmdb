import Foundation
import Testing
@testable import TMDB

struct EndpointFactoryTests {
    @Test func verifyConfigurationURLFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Configuration.details,
            againstPattern: "^/3/configuration$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Configuration.details,
                againstPattern: "^/3/configuration/countries$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Configuration.countries,
            againstPattern: "^/3/configuration/countries$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Configuration.countries,
                againstPattern: "^/3/configuration$",
            )
        }
    }

    @Test func verifyDiscoverFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Discover.movie(filters: []),
            againstPattern: "^/3/discover/movie$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Discover.movie(filters: []),
                againstPattern: "^/3/discover/tv$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Discover.tv(filters: []),
            againstPattern: "^/3/discover/tv$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Discover.tv(filters: []),
                againstPattern: "^/3/discover/movie$",
            )
        }
    }

    @Test func verifyMovieFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Movies.details(id: 0),
            againstPattern: "^/3/movie/\\d+$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Movies.details(id: 0),
                againstPattern: "^/3/movie/\\d+/alternative_titles$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
            againstPattern: "^/3/movie/\\d+/alternative_titles$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
                againstPattern: "^/3/movie/\\d+$",
            )
        }
    }
}

extension EndpointFactoryTests {
    func checkURLFactory(_ factory: any EndpointFactory, againstPattern pattern: String) throws {
        let url = factory.makeURL(baseURL: TMDB.Constants.baseURL)
        let regex = try Regex(pattern)
        guard url.relativePath.contains(regex) else {
            throw URLError(.badURL)
        }
    }
}
