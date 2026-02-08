import Foundation
import Testing
@testable import TMDB

struct CreditEndpointTests {
    @Test func details() async throws {
        _ = try await TMDB.credits(forID: 0)
    }
}
