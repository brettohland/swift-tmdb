import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct CertificationIntegrationTests {
    @Test func movieCertifications() async throws {
        try await withLiveTMDB {
            let certifications = try await TMDB.movieCertifications()
            #expect(!certifications.certifications.isEmpty)
        }
    }

    @Test func tvCertifications() async throws {
        try await withLiveTMDB {
            let certifications = try await TMDB.tvCertifications()
            #expect(!certifications.certifications.isEmpty)
        }
    }
}
