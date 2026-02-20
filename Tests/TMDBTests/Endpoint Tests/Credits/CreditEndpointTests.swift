import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct CreditEndpointTests {
    @Test func details() async throws {
        let details = try await TMDB.credits(forID: "52fe4250c3a36847f80149f3")
        #expect(!details.id.isEmpty)
    }
}
