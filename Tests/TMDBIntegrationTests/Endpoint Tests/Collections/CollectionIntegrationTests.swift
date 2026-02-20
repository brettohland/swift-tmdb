import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct CollectionIntegrationTests {
    @Test func collectionDetails() async throws {
        try await withLiveTMDB {
            let collection = try await TMDB.collectionDetails(id: 2_150)
            #expect(collection.id == 2_150)
            #expect(collection.name == "Shrek Collection")
            #expect(!collection.parts.isEmpty)
        }
    }

    @Test func collectionImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.collectionImages(id: 2_150)
            #expect(!images.backdrops.isEmpty)
        }
    }
}
