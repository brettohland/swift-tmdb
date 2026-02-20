import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct ConfigurationIntegrationTests {
    @Test func details() async throws {
        try await withLiveTMDB {
            let config = try await TMDB.configurationDetails()
            #expect(!config.changeKeys.isEmpty)
        }
    }

    @Test func countries() async throws {
        try await withLiveTMDB {
            let countries = try await TMDB.supportedCountries()
            #expect(!countries.isEmpty)
        }
    }

    @Test func jobs() async throws {
        try await withLiveTMDB {
            let departments = try await TMDB.jobDepartments()
            #expect(!departments.isEmpty)
        }
    }

    @Test func languages() async throws {
        try await withLiveTMDB {
            let languages = try await TMDB.supportedLanguages()
            #expect(!languages.isEmpty)
        }
    }

    @Test func primaryTranslations() async throws {
        try await withLiveTMDB {
            let translations = try await TMDB.primaryTranslations()
            #expect(!translations.isEmpty)
        }
    }

    @Test func timezones() async throws {
        try await withLiveTMDB {
            let timezones = try await TMDB.timezones()
            #expect(!timezones.isEmpty)
        }
    }
}
