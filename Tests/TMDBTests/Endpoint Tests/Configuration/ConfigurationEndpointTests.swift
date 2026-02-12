import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct ConfigurationEndpointTests {
    init() { TMDBMockData.register() }
    @Test func details() async throws {
        let config = try await TMDB.configurationDetails()
        #expect(!config.changeKeys.isEmpty)
    }

    @Test func countries() async throws {
        let countries = try await TMDB.supportedCountries()
        #expect(!countries.isEmpty)
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
