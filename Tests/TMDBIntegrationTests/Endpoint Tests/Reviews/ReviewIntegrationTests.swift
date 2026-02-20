import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct ReviewIntegrationTests {
    @Test func reviewDetails() async throws {
        try await withLiveTMDB {
            // Fetch a real review ID from Fight Club's reviews
            let reviews = try await TMDB.movieReviews(id: 550)
            let reviewID = try #require(reviews.results.first?.id)

            let review = try await TMDB.reviewDetails(id: reviewID)
            #expect(!review.content.isEmpty)
        }
    }
}
