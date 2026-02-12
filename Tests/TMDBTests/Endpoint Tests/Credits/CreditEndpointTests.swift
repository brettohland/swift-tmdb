import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct CreditEndpointTests {
    init() { TMDBMockData.register() }
    @Test func details() async throws {
        let details = try await TMDB.credits(forID: 0)
        #expect(!details.id.isEmpty)
    }

    @Test func detailsForMovie() async throws {
        let movie = try TMDB.Movie.mock()
        let details = try await TMDB.credits(forMovie: movie)
        #expect(!details.id.isEmpty)
    }
}
