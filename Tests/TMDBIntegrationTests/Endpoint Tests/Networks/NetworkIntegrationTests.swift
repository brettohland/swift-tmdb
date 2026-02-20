import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct NetworkIntegrationTests {
    @Test func networkDetails() async throws {
        try await withLiveTMDB {
            let network = try await TMDB.networkDetails(id: 213)
            #expect(network.id == 213)
            #expect(network.name == "Netflix")
        }
    }

    @Test func networkImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.networkImages(id: 213)
            #expect(images.id == 213)
            #expect(!images.logos.isEmpty)
        }
    }
}
