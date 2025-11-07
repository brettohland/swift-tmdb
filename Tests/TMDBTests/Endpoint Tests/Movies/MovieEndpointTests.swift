import Dependencies
import Foundation
import Testing
@testable import TMDB

struct MovieEndpointTests {
    @Test func movieDetails() async throws {
        _ = try await TMDB.movieDetails(0)
    }

    @Test func movieAlternativeTitles() async throws {
        _ = try await TMDB.alternativeMovieTitles(550)

        await #expect(throws: TMDBRequestError.invalidRequestData) {
            _ = try await TMDB.alternativeMovieTitles(0)
        }
    }
}
