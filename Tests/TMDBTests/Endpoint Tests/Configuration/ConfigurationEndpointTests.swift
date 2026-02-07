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

    @Test func jobs() async throws {
        let departments = try await TMDB.jobDepartments()
        #expect(!departments.isEmpty)
    }

    @Test func languages() async throws {
        let languages = try await TMDB.supportedLanguages()
        #expect(!languages.isEmpty)
    }

    @Test func primaryTranslations() async throws {
        let translations = try await TMDB.primaryTranslations()
        #expect(!translations.isEmpty)
    }

    @Test func timezones() async throws {
        let timezones = try await TMDB.timezones()
        #expect(!timezones.isEmpty)
    }
}
