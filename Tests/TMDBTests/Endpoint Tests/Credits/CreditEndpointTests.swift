import Dependencies
import Foundation
import SharedModels
import Testing
@testable import TMDB

struct CreditEndpointTests {
    @Test func details() async throws {
        _ = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDBInternal.Credits.Details.mockData()
            }
        } operation: {
            try await TMDB.Client.Credits.credits(id: 0)
        }
    }
}
