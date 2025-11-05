import Dependencies
import Foundation
import SharedModels
import Testing
@testable import TMDB

struct MovieEndpointTests {
    @Test func movieDetails() async throws {
        let movieDetails = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDBInternal.Movie.Details.mockData()
            }
        } operation: {
            try await TMDB.Client.Movie.details(id: 1)
        }

        #expect(movieDetails.id == 934_433)
    }

    @Test func movieAlternativeTitles() async throws {
        let alternativeTitles = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDBInternal.Movie.AlternativeTitle.mockData()
            }
        } operation: {
            try await TMDB.Client.Movie.alternativeTitles(id: 1)
        }
        #expect(alternativeTitles.id == 550)
    }
}
