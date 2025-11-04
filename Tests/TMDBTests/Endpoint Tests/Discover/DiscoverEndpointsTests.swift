import Dependencies
import Foundation
import Mocks
import SharedModels
import Testing
@testable import TMDB

struct DiscoverEndpointTests {
    @Test func discoverMovies() async throws {
        _ = try await withDependencies {
            $0.httpClient.data = { _, _ in
                let movie = try TMDBInternal.Discover.DiscoverMovie.mock()
                let response = TMDBInternal.Discover.PaginatedResponse<TMDBInternal.Discover.DiscoverMovie>(
                    page: 1,
                    totalResults: 1,
                    totalPages: 1,
                    results: [movie],
                )
                return try JSONEncoder().encode(response)
            }
        } operation: {
            try await TMDB.Client.Discover.movies()
        }


    }

    @Test func discoverTV() async throws {
        _ = try await withDependencies {
            $0.httpClient.data = { _, _ in
                let show = try TMDBInternal.Discover.DiscoverTV.mock()
                let response = TMDBInternal.Discover.PaginatedResponse<TMDBInternal.Discover.DiscoverTV>(
                    page: 1,
                    totalResults: 1,
                    totalPages: 1,
                    results: [show],
                )
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                return try encoder.encode(response)
            }
        } operation: {
            try await TMDB.Client.Discover.tv()
        }
    }
}
