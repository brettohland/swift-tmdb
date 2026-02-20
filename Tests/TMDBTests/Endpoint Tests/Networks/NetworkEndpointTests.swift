import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct NetworkEndpointTests {
    @Test func networkDetails() async throws {
        let network = try await TMDB.networkDetails(id: 213)
        #expect(network.id == 213)
        #expect(!network.name.isEmpty)
    }

    @Test func networkImages() async throws {
        let images = try await TMDB.networkImages(id: 213)
        #expect(images.id == 213)
        #expect(!images.logos.isEmpty)
    }
}
