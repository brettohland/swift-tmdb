import Dependencies
import Foundation
import Testing
@testable import TMDB

struct ConfigurationEndpointTests {
    @Test func details() async throws {
        _ = try await TMDB.apiConfigurationDetails()
    }

    @Test func countries() async throws {
        _ = try await TMDB.supportedCountries()
    }
}
