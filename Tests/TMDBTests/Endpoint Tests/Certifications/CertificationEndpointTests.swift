import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct CertificationEndpointTests {
    init() { TMDBMockData.register() }
    @Test func movieCertifications() async throws {
        let certifications = try await TMDB.movieCertifications()
        #expect(!certifications.certifications.isEmpty)
    }

    @Test func tvCertifications() async throws {
        let certifications = try await TMDB.tvCertifications()
        #expect(!certifications.certifications.isEmpty)
    }
}
