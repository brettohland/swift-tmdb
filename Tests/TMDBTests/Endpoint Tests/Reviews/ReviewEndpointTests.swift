import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct ReviewEndpointTests {
    @Test func reviewDetails() async throws {
        let review = try await TMDB.reviewDetails(id: "5e382d1b4ca676001453826e")
        #expect(!review.content.isEmpty)
    }
}
