internal import Dependencies
import Foundation

extension TMDB.V3Endpoints {
    enum AccountWrite {
        case setFavorite(accountID: String, sessionID: String)
        case setWatchlist(accountID: String, sessionID: String)
        case rateMovie(id: Int, sessionID: String)
        case deleteMovieRating(id: Int, sessionID: String)
        case rateTVSeries(id: Int, sessionID: String)
        case deleteTVSeriesRating(id: Int, sessionID: String)
        case rateTVEpisode(seriesID: Int, seasonNumber: Int, episodeNumber: Int, sessionID: String)
        case deleteTVEpisodeRating(seriesID: Int, seasonNumber: Int, episodeNumber: Int, sessionID: String)
    }
}

extension TMDB.V3Endpoints.AccountWrite: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .setFavorite(let accountID, let sessionID):
            paths.append("account")
            paths.append(accountID)
            paths.append("favorite")
            queryItems.append(.sessionID, value: sessionID)
        case .setWatchlist(let accountID, let sessionID):
            paths.append("account")
            paths.append(accountID)
            paths.append("watchlist")
            queryItems.append(.sessionID, value: sessionID)
        case .rateMovie(let id, let sessionID):
            paths.append("movie")
            paths.append("\(id)")
            paths.append("rating")
            queryItems.append(.sessionID, value: sessionID)
        case .deleteMovieRating(let id, let sessionID):
            paths.append("movie")
            paths.append("\(id)")
            paths.append("rating")
            queryItems.append(.sessionID, value: sessionID)
        case .rateTVSeries(let id, let sessionID):
            paths.append("tv")
            paths.append("\(id)")
            paths.append("rating")
            queryItems.append(.sessionID, value: sessionID)
        case .deleteTVSeriesRating(let id, let sessionID):
            paths.append("tv")
            paths.append("\(id)")
            paths.append("rating")
            queryItems.append(.sessionID, value: sessionID)
        case .rateTVEpisode(let seriesID, let seasonNumber, let episodeNumber, let sessionID):
            paths.append("tv")
            paths.append("\(seriesID)")
            paths.append("season")
            paths.append("\(seasonNumber)")
            paths.append("episode")
            paths.append("\(episodeNumber)")
            paths.append("rating")
            queryItems.append(.sessionID, value: sessionID)
        case .deleteTVEpisodeRating(let seriesID, let seasonNumber, let episodeNumber, let sessionID):
            paths.append("tv")
            paths.append("\(seriesID)")
            paths.append("season")
            paths.append("\(seasonNumber)")
            paths.append("episode")
            paths.append("\(episodeNumber)")
            paths.append("rating")
            queryItems.append(.sessionID, value: sessionID)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Set Favorite

public extension TMDB {
    /// `POST /3/account/{account_id}/favorite`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/account-add-favorite)
    /// - Parameters:
    ///   - mediaType: The type of media (movie or tv)
    ///   - mediaID: The ID of the media item
    ///   - favorite: Whether to mark as favorite or remove from favorites
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func setFavorite(
        mediaType: Account.MediaType,
        mediaID: Int,
        favorite: Bool,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<FavoriteBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.setFavorite(accountID: session.accountID, sessionID: sessionID),
            httpMethod: .post,
            requestBody: FavoriteBody(mediaType: mediaType.rawValue, mediaId: mediaID, favorite: favorite),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Set Watchlist

public extension TMDB {
    /// `POST /3/account/{account_id}/watchlist`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/account-add-to-watchlist)
    /// - Parameters:
    ///   - mediaType: The type of media (movie or tv)
    ///   - mediaID: The ID of the media item
    ///   - watchlist: Whether to add to or remove from watchlist
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func setWatchlist(
        mediaType: Account.MediaType,
        mediaID: Int,
        watchlist: Bool,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<WatchlistBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.setWatchlist(accountID: session.accountID, sessionID: sessionID),
            httpMethod: .post,
            requestBody: WatchlistBody(mediaType: mediaType.rawValue, mediaId: mediaID, watchlist: watchlist),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Rate Movie

public extension TMDB {
    /// `POST /3/movie/{movie_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/movie-add-rating)
    /// - Parameters:
    ///   - id: The movie ID
    ///   - rating: The rating value (0.5-10.0, in 0.5 increments)
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func rateMovie(
        id: Int,
        rating: Double,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<RatingBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.rateMovie(id: id, sessionID: sessionID),
            httpMethod: .post,
            requestBody: RatingBody(value: rating),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Delete Movie Rating

public extension TMDB {
    /// `DELETE /3/movie/{movie_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/movie-delete-rating)
    /// - Parameter id: The movie ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func deleteMovieRating(
        id: Int,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.deleteMovieRating(id: id, sessionID: sessionID),
            httpMethod: .delete,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Rate TV Series

public extension TMDB {
    /// `POST /3/tv/{series_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-series-add-rating)
    /// - Parameters:
    ///   - id: The TV series ID
    ///   - rating: The rating value (0.5-10.0, in 0.5 increments)
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func rateTVSeries(
        id: Int,
        rating: Double,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<RatingBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.rateTVSeries(id: id, sessionID: sessionID),
            httpMethod: .post,
            requestBody: RatingBody(value: rating),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Delete TV Series Rating

public extension TMDB {
    /// `DELETE /3/tv/{series_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-series-delete-rating)
    /// - Parameter id: The TV series ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func deleteTVSeriesRating(
        id: Int,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.deleteTVSeriesRating(id: id, sessionID: sessionID),
            httpMethod: .delete,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Rate TV Episode

public extension TMDB {
    /// `POST /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-episode-add-rating)
    /// - Parameters:
    ///   - seriesID: The TV series ID
    ///   - seasonNumber: The season number
    ///   - episodeNumber: The episode number
    ///   - rating: The rating value (0.5-10.0, in 0.5 increments)
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func rateTVEpisode(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
        rating: Double,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<RatingBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.rateTVEpisode(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
                sessionID: sessionID,
            ),
            httpMethod: .post,
            requestBody: RatingBody(value: rating),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Delete TV Episode Rating

public extension TMDB {
    /// `DELETE /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-episode-delete-rating)
    /// - Parameters:
    ///   - seriesID: The TV series ID
    ///   - seasonNumber: The season number
    ///   - episodeNumber: The episode number
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func deleteTVEpisodeRating(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load(),
              let sessionID = session.sessionID
        else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.deleteTVEpisodeRating(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
                sessionID: sessionID,
            ),
            httpMethod: .delete,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
