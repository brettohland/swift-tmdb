import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct CreditIntegrationTests {
    @Test func creditDetails() async throws {
        try await withLiveTMDB {
            let details = try await TMDB.credits(forID: "52fe4250c3a36847f80149f3")
            #expect(!details.id.isEmpty)
            #expect(!details.department.isEmpty)
        }
    }
}
