import Dependencies
import Foundation
import SharedModels
import Testing
@testable import TMDB

struct ConfigurationEndpointTests {
    @Test func details() async throws {
        _ = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDBInternal.Configuration.Response.mockData()
            }
        } operation: {
            try await TMDB.Client.APIConfiguration.details()
        }
    }

    @Test func countries() async throws {
        _ = try await withDependencies {
            $0.httpClient.data = { _, _ in
                try TMDBInternal.Configuration.CountriesResponse.mockData()
            }
        } operation: {
            try await TMDB.Client.APIConfiguration.countries()
        }
    }
}
