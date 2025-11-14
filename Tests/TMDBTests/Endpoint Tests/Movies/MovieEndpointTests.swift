import Dependencies
import Foundation
import Testing
@testable import TMDB

struct MovieEndpointTests {
    @Test func movieDetails() async throws {
        _ = try await TMDB.movieDetails(id: 0)
    }

    @Test func movieAlternativeTitles() async throws {
        _ = try await TMDB.alternativeMovieTitles(id: 550)
    }
}
