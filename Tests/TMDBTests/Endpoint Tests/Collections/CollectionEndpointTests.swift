import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct CollectionEndpointTests {
    init() { TMDBMockData.register() }
    @Test func collectionDetails() async throws {
        let collection = try await TMDB.collectionDetails(id: 2_150)
        #expect(!collection.name.isEmpty)
        #expect(!collection.parts.isEmpty)
    }

    @Test func collectionImages() async throws {
        let images = try await TMDB.collectionImages(id: 2_150)
        #expect(!images.backdrops.isEmpty)
    }
}
