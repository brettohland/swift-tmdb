import Dependencies
import Foundation
import Testing
@testable import TMDB

struct PeopleEndpointTests {
    @Test func personDetails() async throws {
        let person = try await TMDB.personDetails(id: 287)
        #expect(!person.name.isEmpty)
        #expect(person.id == 287)
        #expect(person.gender == .male)
    }

    @Test func personMovieCredits() async throws {
        let credits = try await TMDB.personMovieCredits(id: 287)
        #expect(credits.id == 287)
        #expect(!credits.cast.isEmpty)
        #expect(!credits.crew.isEmpty)
    }

    @Test func personTVCredits() async throws {
        let credits = try await TMDB.personTVCredits(id: 287)
        #expect(credits.id == 287)
        #expect(!credits.cast.isEmpty)
    }

    @Test func personCombinedCredits() async throws {
        let credits = try await TMDB.personCombinedCredits(id: 287)
        #expect(credits.id == 287)
        #expect(!credits.cast.isEmpty)
        let movieCredit = try #require(credits.cast.first(where: { $0.mediaType == "movie" }))
        #expect(movieCredit.title != nil)
        let tvCredit = try #require(credits.cast.first(where: { $0.mediaType == "tv" }))
        #expect(tvCredit.name != nil)
    }

    @Test func personExternalIDs() async throws {
        let ids = try await TMDB.personExternalIDs(id: 287)
        #expect(ids.id == 287)
        #expect(ids.imdbID != nil)
    }

    @Test func personImages() async throws {
        let images = try await TMDB.personImages(id: 287)
        #expect(images.id == 287)
        #expect(!images.profiles.isEmpty)
    }

    @Test func personTranslations() async throws {
        let translations = try await TMDB.personTranslations(id: 287)
        #expect(translations.id == 287)
        #expect(!translations.translations.isEmpty)
        let first = try #require(translations.translations.first)
        #expect(first.data.biography != nil)
    }

    @Test func popularPeople() async throws {
        let people = try await TMDB.popularPeople()
        #expect(!people.results.isEmpty)
        let first = try #require(people.results.first)
        #expect(!first.name.isEmpty)
        #expect(!first.knownFor.isEmpty)
    }
}
