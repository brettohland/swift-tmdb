import Dependencies
import Foundation
import Testing
@testable import TMDB

struct CreditEndpointTests {
    @Test func details() async throws {
        _ = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDB.Credits.Details.mockData()
            }
        } operation: {
            try await TMDB.credits(forID: 0)
        }
    }
}
