import Foundation
import RequestService
import SharedModels
import Testing
@testable import TMDB

struct EndpointFactoryTests {
    @Test func verifyConfigurationURLFactories() throws {
        try checkURLFactory(
            TMDBInternal.V3Endpoints.Configuration.details,
            againstPattern: TMDBInternal.V3Endpoints.Configuration.details,
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDBInternal.V3Endpoints.Configuration.details,
                againstPattern: TMDBInternal.V3Endpoints.Configuration.countries,
            )
        }
        try checkURLFactory(
            TMDBInternal.V3Endpoints.Configuration.countries,
            againstPattern: TMDBInternal.V3Endpoints.Configuration.countries,
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDBInternal.V3Endpoints.Configuration.countries,
                againstPattern: TMDBInternal.V3Endpoints.Configuration.details,
            )
        }
    }

    @Test func verifyDiscoverFactories() throws {
        try checkURLFactory(
            TMDBInternal.V3Endpoints.Discover.movie(filters: []),
            againstPattern: TMDBInternal.V3Endpoints.Discover.movie(filters: []),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDBInternal.V3Endpoints.Discover.movie(filters: []),
                againstPattern: TMDBInternal.V3Endpoints.Discover.tv(filters: []),
            )
        }
        try checkURLFactory(
            TMDBInternal.V3Endpoints.Discover.tv(filters: []),
            againstPattern: TMDBInternal.V3Endpoints.Discover.tv(filters: []),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDBInternal.V3Endpoints.Discover.tv(filters: []),
                againstPattern: TMDBInternal.V3Endpoints.Discover.movie(filters: []),
            )
        }
    }

    @Test func verifyMovieFactories() throws {
        try checkURLFactory(
            TMDBInternal.V3Endpoints.Movies.details(id: 0),
            againstPattern: TMDBInternal.V3Endpoints.Movies.details(id: 0),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDBInternal.V3Endpoints.Movies.details(id: 0),
                againstPattern: TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: 0),
            )
        }
        try checkURLFactory(
            TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: 0),
            againstPattern: TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: 0),
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: 0),
                againstPattern: TMDBInternal.V3Endpoints.Movies.details(id: 0),
            )
        }
    }
}

extension EndpointFactoryTests {
    enum Error: Swift.Error {
        case badURL
    }

    func checkURLFactory(_ factory: any EndpointFactory, againstPattern path: any RegexComparable) throws {
        let url = factory.makeURL(baseURL: TMDB.Client.Constants.baseURL)
        guard url.relativePath.contains(path.pattern) else {
            throw URLError(.badURL)
        }
    }
}
