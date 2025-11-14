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
        )
    }
}
