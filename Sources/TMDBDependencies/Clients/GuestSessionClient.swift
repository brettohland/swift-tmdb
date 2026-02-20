@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct GuestSessionClient: Sendable {
    // MARK: - Read

    /// Create a new guest session
    public var createGuestSession: @Sendable () async throws -> TMDB.Auth.GuestSession
    /// Get the rated movies for a guest session
    public var guestRatedMovies: @Sendable (
        _ sessionID: String,
        _ sortBy: TMDB.Account.SortOrder?,
        _ page: Int,
        _ language: Locale?,
    ) async throws -> TMDB.Discover.PaginatedResponse<TMDB.GuestSession.RatedMovie>
    /// Get the rated TV shows for a guest session
    public var guestRatedTV: @Sendable (
        _ sessionID: String,
        _ sortBy: TMDB.Account.SortOrder?,
        _ page: Int,
        _ language: Locale?,
    ) async throws -> TMDB.Discover.PaginatedResponse<TMDB.GuestSession.RatedTV>
    /// Get the rated TV episodes for a guest session
    public var guestRatedEpisodes: @Sendable (
        _ sessionID: String,
        _ sortBy: TMDB.Account.SortOrder?,
        _ page: Int,
        _ language: Locale?,
    ) async throws -> TMDB.Discover.PaginatedResponse<TMDB.GuestSession.RatedEpisode>

    // MARK: - Write

    /// Rate a movie as a guest
    public var guestRateMovie: @Sendable (
        _ id: Int,
        _ rating: Double,
        _ guestSessionID: String,
    ) async throws -> TMDB.Account.WriteResult
    /// Delete a movie rating as a guest
    public var guestDeleteMovieRating: @Sendable (
        _ id: Int,
        _ guestSessionID: String,
    ) async throws -> TMDB.Account.WriteResult
    /// Rate a TV series as a guest
    public var guestRateTVSeries: @Sendable (
        _ id: Int,
        _ rating: Double,
        _ guestSessionID: String,
    ) async throws -> TMDB.Account.WriteResult
    /// Delete a TV series rating as a guest
    public var guestDeleteTVSeriesRating: @Sendable (
        _ id: Int,
        _ guestSessionID: String,
    ) async throws -> TMDB.Account.WriteResult
    /// Rate a TV episode as a guest
    public var guestRateTVEpisode: @Sendable (
        _ seriesID: Int,
        _ seasonNumber: Int,
        _ episodeNumber: Int,
        _ rating: Double,
        _ guestSessionID: String,
    ) async throws -> TMDB.Account.WriteResult
    /// Delete a TV episode rating as a guest
    public var guestDeleteTVEpisodeRating: @Sendable (
        _ seriesID: Int,
        _ seasonNumber: Int,
        _ episodeNumber: Int,
        _ guestSessionID: String,
    ) async throws -> TMDB.Account.WriteResult
}

public extension DependencyValues {
    /// Dependency that represents the TMDB guest session endpoints
    var tmdbGuestSession: GuestSessionClient {
        get { self[GuestSessionClient.self] }
        set { self[GuestSessionClient.self] = newValue }
    }
}

extension GuestSessionClient: DependencyKey {
    public static var liveValue: GuestSessionClient {
        Self(
            createGuestSession: {
                try await TMDB.createGuestSession()
            },
            guestRatedMovies: {
                try await TMDB.guestRatedMovies(sessionID: $0, sortBy: $1, page: $2, language: $3)
            },
            guestRatedTV: {
                try await TMDB.guestRatedTV(sessionID: $0, sortBy: $1, page: $2, language: $3)
            },
            guestRatedEpisodes: {
                try await TMDB.guestRatedEpisodes(sessionID: $0, sortBy: $1, page: $2, language: $3)
            },
            guestRateMovie: {
                try await TMDB.guestRateMovie(id: $0, rating: $1, guestSessionID: $2)
            },
            guestDeleteMovieRating: {
                try await TMDB.guestDeleteMovieRating(id: $0, guestSessionID: $1)
            },
            guestRateTVSeries: {
                try await TMDB.guestRateTVSeries(id: $0, rating: $1, guestSessionID: $2)
            },
            guestDeleteTVSeriesRating: {
                try await TMDB.guestDeleteTVSeriesRating(id: $0, guestSessionID: $1)
            },
            guestRateTVEpisode: {
                try await TMDB.guestRateTVEpisode(
                    seriesID: $0,
                    seasonNumber: $1,
                    episodeNumber: $2,
                    rating: $3,
                    guestSessionID: $4,
                )
            },
            guestDeleteTVEpisodeRating: {
                try await TMDB.guestDeleteTVEpisodeRating(
                    seriesID: $0,
                    seasonNumber: $1,
                    episodeNumber: $2,
                    guestSessionID: $3,
                )
            },
        )
    }
}
