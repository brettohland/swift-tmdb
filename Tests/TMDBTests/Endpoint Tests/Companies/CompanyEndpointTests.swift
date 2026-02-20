import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct CompanyEndpointTests {
    @Test func companyDetails() async throws {
        let company = try await TMDB.companyDetails(id: 1)
        #expect(company.id == 1)
        #expect(!company.name.isEmpty)
        #expect(company.parentCompany != nil)
    }

    @Test func companyImages() async throws {
        let images = try await TMDB.companyImages(id: 1)
        #expect(images.id == 1)
        #expect(!images.logos.isEmpty)
    }
}
