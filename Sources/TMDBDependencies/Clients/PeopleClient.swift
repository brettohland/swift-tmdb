@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct PeopleClient: Sendable {
    public var personDetails: @Sendable (_ id: Int) async throws -> TMDB.Person
    public var personMovieCredits: @Sendable (_ id: Int) async throws -> TMDB.PersonMovieCredits
    public var personTVCredits: @Sendable (_ id: Int) async throws -> TMDB.PersonTVCredits
    public var personCombinedCredits: @Sendable (_ id: Int) async throws -> TMDB.PersonCombinedCredits
    public var personExternalIDs: @Sendable (_ id: Int) async throws -> TMDB.ExternalIDs
    public var personImages: @Sendable (_ id: Int) async throws -> TMDB.PersonImages
    public var personTranslations: @Sendable (_ id: Int) async throws -> TMDB.TranslationCollection
    public var popularPeople: @Sendable (_ page: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.PopularPerson>
}

public extension DependencyValues {
    var tmdbPeople: PeopleClient {
        get { self[PeopleClient.self] }
        set { self[PeopleClient.self] = newValue }
    }
}

extension PeopleClient: DependencyKey {
    public static var liveValue: PeopleClient {
        Self(
            personDetails: { try await TMDB.personDetails(id: $0) },
            personMovieCredits: { try await TMDB.personMovieCredits(id: $0) },
            personTVCredits: { try await TMDB.personTVCredits(id: $0) },
            personCombinedCredits: { try await TMDB.personCombinedCredits(id: $0) },
            personExternalIDs: { try await TMDB.personExternalIDs(id: $0) },
            personImages: { try await TMDB.personImages(id: $0) },
            personTranslations: { try await TMDB.personTranslations(id: $0) },
            popularPeople: { try await TMDB.popularPeople(page: $0) },
        )
    }
}
