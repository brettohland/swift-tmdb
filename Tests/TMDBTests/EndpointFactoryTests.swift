import Foundation
import Testing
@testable import TMDB

struct EndpointFactoryTests {
    @Test func verifyConfigurationURLFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Configuration.details,
            againstPattern: TMDB.V3Endpoints.Configuration.details,
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Configuration.details,
                againstPattern: TMDB.V3Endpoints.Configuration.countries,
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Configuration.countries,
            againstPattern: TMDB.V3Endpoints.Configuration.countries,
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Configuration.countries,
                againstPattern: TMDB.V3Endpoints.Configuration.details,
            )
        }
    }

    @Test func verifyDiscoverFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Discover.movie(filters: []),
            againstPattern: TMDB.V3Endpoints.Discover.movie(filters: []),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Discover.movie(filters: []),
                againstPattern: TMDB.V3Endpoints.Discover.tv(filters: []),
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Discover.tv(filters: []),
            againstPattern: TMDB.V3Endpoints.Discover.tv(filters: []),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Discover.tv(filters: []),
                againstPattern: TMDB.V3Endpoints.Discover.movie(filters: []),
            )
        }
    }

    @Test func verifyMovieFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Movies.details(id: 0),
            againstPattern: TMDB.V3Endpoints.Movies.details(id: 0),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Movies.details(id: 0),
                againstPattern: TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
            againstPattern: TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
                againstPattern: TMDB.V3Endpoints.Movies.details(id: 0),
            )
        }
    }
}

extension EndpointFactoryTests {
    enum Error: Swift.Error {
        case badURL
    }

    func checkURLFactory(_ factory: any EndpointFactory, againstPattern path: any RegexComparable) throws {
        let url = factory.makeURL(baseURL: TMDB.Constants.baseURL)
        guard try url.relativePath.contains(path.pattern()) else {
            throw URLError(.badURL)
        }
    }
}
