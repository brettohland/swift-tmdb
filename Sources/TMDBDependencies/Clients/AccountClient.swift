@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct AccountClient: Sendable {
    // MARK: - V4 Account Read

    /// Get the lists created by an account
    public var accountLists: @Sendable (_ page: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Account.AccountList>
    /// Get the list of favorite movies
    public var favoriteMovies: @Sendable (
        _ sortBy: TMDB.Account.SortOrder?,
        _ page: Int,
        _ language: Locale?,
    ) async throws -> TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Get the list of favorite TV series
    public var favoriteTVSeries: @Sendable (
        _ sortBy: TMDB.Account.SortOrder?,
        _ page: Int,
        _ language: Locale?,
    ) async throws -> TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>
    /// Get the list of rated movies
    public var ratedMovies: @Sendable (
        _ sortBy: TMDB.Account.SortOrder?,
        _ page: Int,
        _ language: Locale?,
    ) async throws -> TMDB.Discover.PaginatedResponse<TMDB.Account.RatedMovie>
    /// Get the list of rated TV series
    public var ratedTVSeries: @Sendable (
        _ sortBy: TMDB.Account.SortOrder?,
        _ page: Int,
        _ language: Locale?,
    ) async throws -> TMDB.Discover.PaginatedResponse<TMDB.Account.RatedTV>
    /// Get personalized movie recommendations
    public var accountMovieRecommendations: @Sendable (_ page: Int, _ language: Locale?) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Get personalized TV recommendations
    public var accountTVRecommendations: @Sendable (_ page: Int, _ language: Locale?) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverTV>
    /// Get the list of movies on the watchlist
    public var watchlistMovies: @Sendable (_ page: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Get the list of TV series on the watchlist
    public var watchlistTVSeries: @Sendable (_ page: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverTV>

    // MARK: - V3 Account Write

    /// Add or remove a movie/TV show from favorites
    public var setFavorite: @Sendable (
        _ mediaType: TMDB.Account.MediaType,
        _ mediaID: Int,
        _ favorite: Bool,
    ) async throws -> TMDB.Account.WriteResult
    /// Add or remove a movie/TV show from the watchlist
    public var setWatchlist: @Sendable (
        _ mediaType: TMDB.Account.MediaType,
        _ mediaID: Int,
        _ watchlist: Bool,
    ) async throws -> TMDB.Account.WriteResult
    /// Rate a movie
    public var rateMovie: @Sendable (_ id: Int, _ rating: Double) async throws -> TMDB.Account.WriteResult
    /// Delete a movie rating
    public var deleteMovieRating: @Sendable (_ id: Int) async throws -> TMDB.Account.WriteResult
    /// Rate a TV series
    public var rateTVSeries: @Sendable (_ id: Int, _ rating: Double) async throws -> TMDB.Account.WriteResult
    /// Delete a TV series rating
    public var deleteTVSeriesRating: @Sendable (_ id: Int) async throws -> TMDB.Account.WriteResult
    /// Rate a TV episode
    public var rateTVEpisode: @Sendable (
        _ seriesID: Int,
        _ seasonNumber: Int,
        _ episodeNumber: Int,
        _ rating: Double,
    ) async throws -> TMDB.Account.WriteResult
    /// Delete a TV episode rating
    public var deleteTVEpisodeRating: @Sendable (
        _ seriesID: Int,
        _ seasonNumber: Int,
        _ episodeNumber: Int,
    ) async throws -> TMDB.Account.WriteResult
}

public extension DependencyValues {
    /// Dependency that represents the TMDB account endpoints
    var tmdbAccount: AccountClient {
        get { self[AccountClient.self] }
        set { self[AccountClient.self] = newValue }
    }
}

extension AccountClient: DependencyKey {
    public static var liveValue: AccountClient {
        Self(
            accountLists: {
                try await TMDB.accountLists(page: $0)
            },
            favoriteMovies: {
                try await TMDB.favoriteMovies(sortBy: $0, page: $1, language: $2)
            },
            favoriteTVSeries: {
                try await TMDB.favoriteTVSeries(sortBy: $0, page: $1, language: $2)
            },
            ratedMovies: {
                try await TMDB.ratedMovies(sortBy: $0, page: $1, language: $2)
            },
            ratedTVSeries: {
                try await TMDB.ratedTVSeries(sortBy: $0, page: $1, language: $2)
            },
            accountMovieRecommendations: {
                try await TMDB.accountMovieRecommendations(page: $0, language: $1)
            },
            accountTVRecommendations: {
                try await TMDB.accountTVRecommendations(page: $0, language: $1)
            },
            watchlistMovies: {
                try await TMDB.watchlistMovies(page: $0)
            },
            watchlistTVSeries: {
                try await TMDB.watchlistTVSeries(page: $0)
            },
            setFavorite: {
                try await TMDB.setFavorite(mediaType: $0, mediaID: $1, favorite: $2)
            },
            setWatchlist: {
                try await TMDB.setWatchlist(mediaType: $0, mediaID: $1, watchlist: $2)
            },
            rateMovie: {
                try await TMDB.rateMovie(id: $0, rating: $1)
            },
            deleteMovieRating: {
                try await TMDB.deleteMovieRating(id: $0)
            },
            rateTVSeries: {
                try await TMDB.rateTVSeries(id: $0, rating: $1)
            },
            deleteTVSeriesRating: {
                try await TMDB.deleteTVSeriesRating(id: $0)
            },
            rateTVEpisode: {
                try await TMDB.rateTVEpisode(seriesID: $0, seasonNumber: $1, episodeNumber: $2, rating: $3)
            },
            deleteTVEpisodeRating: {
                try await TMDB.deleteTVEpisodeRating(seriesID: $0, seasonNumber: $1, episodeNumber: $2)
            },
        )
    }
}
