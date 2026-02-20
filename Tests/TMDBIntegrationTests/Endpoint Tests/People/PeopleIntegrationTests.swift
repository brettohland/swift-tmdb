import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct PeopleIntegrationTests {
    @Test func personDetails() async throws {
        try await withLiveTMDB {
            let person = try await TMDB.personDetails(id: 287)
            #expect(person.id == 287)
            #expect(person.name == "Brad Pitt")
        }
    }

    @Test func personMovieCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.personMovieCredits(id: 287)
            #expect(credits.id == 287)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func personTVCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.personTVCredits(id: 287)
            #expect(credits.id == 287)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func personCombinedCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.personCombinedCredits(id: 287)
            #expect(credits.id == 287)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func personExternalIDs() async throws {
        try await withLiveTMDB {
            let ids = try await TMDB.personExternalIDs(id: 287)
            #expect(ids.id == 287)
            #expect(ids.imdbID != nil)
        }
    }

    @Test func personImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.personImages(id: 287)
            #expect(images.id == 287)
            #expect(!images.profiles.isEmpty)
        }
    }

    @Test func personTranslations() async throws {
        try await withLiveTMDB {
            let translations = try await TMDB.personTranslations(id: 287)
            #expect(translations.id == 287)
            #expect(!translations.translations.isEmpty)
        }
    }

    @Test func popularPeople() async throws {
        try await withLiveTMDB {
            let people = try await TMDB.popularPeople()
            #expect(!people.results.isEmpty)
        }
    }
}
