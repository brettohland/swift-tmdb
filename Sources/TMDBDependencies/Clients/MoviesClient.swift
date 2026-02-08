@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct MoviesClient: Sendable {
    /// Make a request to the TMDB API's `/3/movie/{id}` endpoint
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/Movie``
    /// - Throws: ``TMDBRequestError``
    public var movieDetails: @Sendable (_ id: Int) async throws -> TMDB.Movie
    /// Make a request to the TMDB API's `/3/movie/{id}/alternative_titles` endpoint and returns only the
    /// array of alternative titles.
    ///
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: An array of ``TMDB/AlternativeTitle`` values
    /// - Throws: ``TMDBRequestError
    public var alternativeMovieTitle: @Sendable (_ id: Int) async throws -> [TMDB.AlternativeTitle]
    /// Make a request to the TMDB API's `/3/movie/{id}/alternative_titles` endpoint and returns only the
    /// array of alternative titles.
    ///
    /// - Parameter movie: ``TMDB/Movie``
    /// - Returns: An array of ``TMDB/AlternativeTitle`` values
    /// - Throws: ``TMDBRequestError
    public var alternativeMovieTitles: @Sendable (_ movie: TMDB.Movie) async throws -> [TMDB.AlternativeTitle]
    /// Make a request to the TMDB API's `/3/movie/{id}/credits` endpoint
    public var movieCredits: @Sendable (_ id: Int) async throws -> TMDB.MovieCredits
    /// Make a request to the TMDB API's `/3/movie/{id}/images` endpoint
    public var movieImages: @Sendable (_ id: Int) async throws -> TMDB.ImageCollection
    /// Make a request to the TMDB API's `/3/movie/{id}/videos` endpoint
    public var movieVideos: @Sendable (_ id: Int) async throws -> TMDB.VideoCollection
    /// Make a request to the TMDB API's `/3/movie/{id}/reviews` endpoint
    public var movieReviews: @Sendable (_ id: Int) async throws -> TMDB.Discover.PaginatedResponse<TMDB.Review>
    /// Make a request to the TMDB API's `/3/movie/{id}/keywords` endpoint
    public var movieKeywords: @Sendable (_ id: Int) async throws -> [TMDB.Keyword]
    /// Make a request to the TMDB API's `/3/movie/{id}/similar` endpoint
    public var similarMovies: @Sendable (_ id: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Make a request to the TMDB API's `/3/movie/{id}/recommendations` endpoint
    public var movieRecommendations: @Sendable (_ id: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Make a request to the TMDB API's `/3/movie/{id}/release_dates` endpoint
    public var movieReleaseDates: @Sendable (_ id: Int) async throws -> [TMDB.ReleaseDateResult]
    /// Make a request to the TMDB API's `/3/movie/{id}/external_ids` endpoint
    public var movieExternalIDs: @Sendable (_ id: Int) async throws -> TMDB.ExternalIDs
    /// Make a request to the TMDB API's `/3/movie/{id}/translations` endpoint
    public var movieTranslations: @Sendable (_ id: Int) async throws -> [TMDB.Translation]
    /// Make a request to the TMDB API's `/3/movie/{id}/watch/providers` endpoint
    public var movieWatchProviders: @Sendable (_ id: Int) async throws -> TMDB.MovieWatchProviderResult
    /// Make a request to the TMDB API's `/3/movie/{id}/changes` endpoint
    public var movieChanges: @Sendable (_ id: Int) async throws -> TMDB.ChangeCollection
    /// Make a request to the TMDB API's `/3/movie/latest` endpoint
    public var latestMovie: @Sendable () async throws -> TMDB.Movie
    /// Make a request to the TMDB API's `/3/movie/now_playing` endpoint
    public var moviesNowPlaying: @Sendable () async throws -> TMDB.Discover
        .DatedPaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Make a request to the TMDB API's `/3/movie/popular` endpoint
    public var popularMovies: @Sendable () async throws -> TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Make a request to the TMDB API's `/3/movie/top_rated` endpoint
    public var topRatedMovies: @Sendable () async throws -> TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>
    /// Make a request to the TMDB API's `/3/movie/upcoming` endpoint
    public var upcomingMovies: @Sendable () async throws -> TMDB.Discover
        .DatedPaginatedResponse<TMDB.Discover.DiscoverMovie>
}

public extension DependencyValues {
    /// Dependency that represents the `/3/movies` TMDB endpoint
    var tmdbMovies: MoviesClient {
        get { self[MoviesClient.self] }
        set { self[MoviesClient.self] = newValue }
    }
}

extension MoviesClient: DependencyKey {
    public static var liveValue: MoviesClient {
        Self(
            movieDetails: {
                try await TMDB.movieDetails(id: $0)
            },
            alternativeMovieTitle: {
                try await TMDB.alternativeMovieTitles(id: $0)
            },
            alternativeMovieTitles: {
                try await TMDB.alternativeMovieTitles(movie: $0)
            },
            movieCredits: {
                try await TMDB.movieCredits(id: $0)
            },
            movieImages: {
                try await TMDB.movieImages(id: $0)
            },
            movieVideos: {
                try await TMDB.movieVideos(id: $0)
            },
            movieReviews: {
                try await TMDB.movieReviews(id: $0)
            },
            movieKeywords: {
                try await TMDB.movieKeywords(id: $0)
            },
            similarMovies: {
                try await TMDB.similarMovies(id: $0)
            },
            movieRecommendations: {
                try await TMDB.movieRecommendations(id: $0)
            },
            movieReleaseDates: {
                try await TMDB.movieReleaseDates(id: $0)
            },
            movieExternalIDs: {
                try await TMDB.movieExternalIDs(id: $0)
            },
            movieTranslations: {
                try await TMDB.movieTranslations(id: $0)
            },
            movieWatchProviders: {
                try await TMDB.movieWatchProviders(id: $0)
            },
            movieChanges: {
                try await TMDB.movieChanges(id: $0)
            },
            latestMovie: {
                try await TMDB.latestMovie()
            },
            moviesNowPlaying: {
                try await TMDB.moviesNowPlaying()
            },
            popularMovies: {
                try await TMDB.popularMovies()
            },
            topRatedMovies: {
                try await TMDB.topRatedMovies()
            },
            upcomingMovies: {
                try await TMDB.upcomingMovies()
            },
        )
    }
}
