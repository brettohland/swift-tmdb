import Dependencies
import Foundation
import SharedModels
import Testing
@testable import TMDB

struct MovieEndpointTests {
    @Test func movieDetails() async throws {
        let movieDetails = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDBInternal.V3Endpoints.Movies.details(id: 1).mockData()
            }
        } operation: {
            try await TMDB.Client.Movie.details(id: 1)
        }

        #expect(movieDetails.id == 934_433)
    }

    @Test func movieAlternativeTitles() async throws {
        let movieDetails = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: 1).mockData()
            }
        } operation: {
            try await TMDB.Client.Movie.alternativeTitles(id: 1)
        }
    }
}
