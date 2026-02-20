import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct CompanyIntegrationTests {
    @Test func companyDetails() async throws {
        try await withLiveTMDB {
            let company = try await TMDB.companyDetails(id: 1)
            #expect(company.id == 1)
            #expect(company.name == "Lucasfilm Ltd.")
        }
    }

    @Test func companyImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.companyImages(id: 1)
            #expect(images.id == 1)
            #expect(!images.logos.isEmpty)
        }
    }
}
