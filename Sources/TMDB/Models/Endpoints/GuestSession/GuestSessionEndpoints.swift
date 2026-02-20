import Foundation

extension TMDB.V3Endpoints {
    enum GuestSession {
        case create
        case ratedMovies(guestSessionID: String, sortBy: TMDB.Account.SortOrder?, page: Int, language: Locale?)
        case ratedTV(guestSessionID: String, sortBy: TMDB.Account.SortOrder?, page: Int, language: Locale?)
        case ratedEpisodes(guestSessionID: String, sortBy: TMDB.Account.SortOrder?, page: Int, language: Locale?)
    }
}

extension TMDB.V3Endpoints.GuestSession: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .create:
            paths.append("authentication")
            paths.append("guest_session")
            paths.append("new")
        case .ratedMovies(let guestSessionID, let sortBy, let page, let language):
            paths.append("guest_session")
            paths.append(guestSessionID)
            paths.append("rated")
            paths.append("movies")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.sortBy, value: sortBy)
            queryItems.appendIfPresent(.language, value: language)
        case .ratedTV(let guestSessionID, let sortBy, let page, let language):
            paths.append("guest_session")
            paths.append(guestSessionID)
            paths.append("rated")
            paths.append("tv")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.sortBy, value: sortBy)
            queryItems.appendIfPresent(.language, value: language)
        case .ratedEpisodes(let guestSessionID, let sortBy, let page, let language):
            paths.append("guest_session")
            paths.append(guestSessionID)
            paths.append("rated")
            paths.append("tv")
            paths.append("episodes")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.sortBy, value: sortBy)
            queryItems.appendIfPresent(.language, value: language)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Create Guest Session

public extension TMDB {
    /// `GET /3/authentication/guest_session/new`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/authentication-create-guest-session)
    /// - Returns: ``TMDB/Auth/GuestSession``
    /// - Throws: ``TMDBRequestError``
    static func createGuestSession() async throws(TMDBRequestError) -> Auth.GuestSession {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Auth.GuestSession>(
            endpoint: V3Endpoints.GuestSession.create,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Guest Rated Movies

public extension TMDB {
    /// `GET /3/guest_session/{guest_session_id}/rated/movies`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/guest-session-rated-movies)
    /// - Parameters:
    ///   - sessionID: The guest session ID
    ///   - sortBy: Sort order for results
    ///   - page: Page number
    ///   - language: Language locale
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/GuestSession/RatedMovie``
    /// - Throws: ``TMDBRequestError``
    static func guestRatedMovies(
        sessionID: String,
        sortBy: Account.SortOrder? = nil,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<GuestSession.RatedMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<GuestSession.RatedMovie>>(
            endpoint: V3Endpoints.GuestSession.ratedMovies(
                guestSessionID: sessionID,
                sortBy: sortBy,
                page: page,
                language: language,
            ),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Guest Rated TV

public extension TMDB {
    /// `GET /3/guest_session/{guest_session_id}/rated/tv`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/guest-session-rated-tv)
    /// - Parameters:
    ///   - sessionID: The guest session ID
    ///   - sortBy: Sort order for results
    ///   - page: Page number
    ///   - language: Language locale
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/GuestSession/RatedTV``
    /// - Throws: ``TMDBRequestError``
    static func guestRatedTV(
        sessionID: String,
        sortBy: Account.SortOrder? = nil,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<GuestSession.RatedTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<GuestSession.RatedTV>>(
            endpoint: V3Endpoints.GuestSession.ratedTV(
                guestSessionID: sessionID,
                sortBy: sortBy,
                page: page,
                language: language,
            ),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Guest Rated Episodes

public extension TMDB {
    /// `GET /3/guest_session/{guest_session_id}/rated/tv/episodes`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/guest-session-rated-tv-episodes)
    /// - Parameters:
    ///   - sessionID: The guest session ID
    ///   - sortBy: Sort order for results
    ///   - page: Page number
    ///   - language: Language locale
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/GuestSession/RatedEpisode``
    /// - Throws: ``TMDBRequestError``
    static func guestRatedEpisodes(
        sessionID: String,
        sortBy: Account.SortOrder? = nil,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<GuestSession.RatedEpisode> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<GuestSession.RatedEpisode>>(
            endpoint: V3Endpoints.GuestSession.ratedEpisodes(
                guestSessionID: sessionID,
                sortBy: sortBy,
                page: page,
                language: language,
            ),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Guest Rate Movie

public extension TMDB {
    /// `POST /3/movie/{movie_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/movie-add-rating)
    /// - Parameters:
    ///   - id: The movie ID
    ///   - rating: The rating value (0.5-10.0, in 0.5 increments)
    ///   - guestSessionID: The guest session ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func guestRateMovie(
        id: Int,
        rating: Double,
        guestSessionID: String,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<RatingBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.guestRateMovie(id: id, guestSessionID: guestSessionID),
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

// MARK: - Guest Delete Movie Rating

public extension TMDB {
    /// `DELETE /3/movie/{movie_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/movie-delete-rating)
    /// - Parameters:
    ///   - id: The movie ID
    ///   - guestSessionID: The guest session ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func guestDeleteMovieRating(
        id: Int,
        guestSessionID: String,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.guestDeleteMovieRating(id: id, guestSessionID: guestSessionID),
            httpMethod: .delete,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Guest Rate TV Series

public extension TMDB {
    /// `POST /3/tv/{series_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-series-add-rating)
    /// - Parameters:
    ///   - id: The TV series ID
    ///   - rating: The rating value (0.5-10.0, in 0.5 increments)
    ///   - guestSessionID: The guest session ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func guestRateTVSeries(
        id: Int,
        rating: Double,
        guestSessionID: String,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<RatingBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.guestRateTVSeries(id: id, guestSessionID: guestSessionID),
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

// MARK: - Guest Delete TV Series Rating

public extension TMDB {
    /// `DELETE /3/tv/{series_id}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-series-delete-rating)
    /// - Parameters:
    ///   - id: The TV series ID
    ///   - guestSessionID: The guest session ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func guestDeleteTVSeriesRating(
        id: Int,
        guestSessionID: String,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.guestDeleteTVSeriesRating(id: id, guestSessionID: guestSessionID),
            httpMethod: .delete,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Guest Rate TV Episode

public extension TMDB {
    /// `POST /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-episode-add-rating)
    /// - Parameters:
    ///   - seriesID: The TV series ID
    ///   - seasonNumber: The season number
    ///   - episodeNumber: The episode number
    ///   - rating: The rating value (0.5-10.0, in 0.5 increments)
    ///   - guestSessionID: The guest session ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func guestRateTVEpisode(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
        rating: Double,
        guestSessionID: String,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<RatingBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.guestRateTVEpisode(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
                guestSessionID: guestSessionID,
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

// MARK: - Guest Delete TV Episode Rating

public extension TMDB {
    /// `DELETE /3/tv/{series_id}/season/{season_number}/episode/{episode_number}/rating`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/tv-episode-delete-rating)
    /// - Parameters:
    ///   - seriesID: The TV series ID
    ///   - seasonNumber: The season number
    ///   - episodeNumber: The episode number
    ///   - guestSessionID: The guest session ID
    /// - Returns: ``TMDB/Account/WriteResult``
    /// - Throws: ``TMDBRequestError``
    static func guestDeleteTVEpisodeRating(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
        guestSessionID: String,
    ) async throws(TMDBRequestError) -> Account.WriteResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Account.WriteResult>(
            endpoint: V3Endpoints.AccountWrite.guestDeleteTVEpisodeRating(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
                guestSessionID: guestSessionID,
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
