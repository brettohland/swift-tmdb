import Foundation

extension TMDB.V3Endpoints {
    enum Movies {
        case details(id: Int, language: Locale?)
        case alternativeTitles(id: Int)
        case credits(id: Int, language: Locale?)
        case images(id: Int, language: Locale?)
        case videos(id: Int, language: Locale?)
        case reviews(id: Int, page: Int, language: Locale?)
        case keywords(id: Int)
        case similar(id: Int, page: Int, language: Locale?)
        case recommendations(id: Int, page: Int, language: Locale?)
        case releaseDates(id: Int)
        case externalIDs(id: Int)
        case translations(id: Int)
        case watchProviders(id: Int)
        case changes(id: Int, startDate: Date?, endDate: Date?, page: Int)
        case latest(language: Locale?)
        case nowPlaying(page: Int, language: Locale?, region: Locale.Region?)
        case popular(page: Int, language: Locale?, region: Locale.Region?)
        case topRated(page: Int, language: Locale?, region: Locale.Region?)
        case upcoming(page: Int, language: Locale?, region: Locale.Region?)
    }
}

extension TMDB.V3Endpoints.Movies: EndpointFactory {
    var supportsLanguage: Bool {
        switch self {
        case .externalIDs,
             .keywords,
             .releaseDates,
             .watchProviders:
            false
        default:
            true
        }
    }

    var supportsRegion: Bool {
        switch self {
        case .nowPlaying,
             .popular,
             .topRated,
             .upcoming:
            true
        default:
            false
        }
    }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "movie"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let id, let language):
            // /3/movie/{ID}
            paths.append(String(id))
            queryItems.appendIfPresent(.language, value: language)
        case .alternativeTitles(let id):
            // /3/movie/{ID}/alternative_titles
            paths += [String(id), "alternative_titles"]
        case .credits(let id, let language):
            // /3/movie/{ID}/credits
            paths += [String(id), "credits"]
            queryItems.appendIfPresent(.language, value: language)
        case .images(let id, let language):
            // /3/movie/{ID}/images
            paths += [String(id), "images"]
            queryItems.appendIfPresent(.language, value: language)
        case .videos(let id, let language):
            // /3/movie/{ID}/videos
            paths += [String(id), "videos"]
            queryItems.appendIfPresent(.language, value: language)
        case .reviews(let id, let page, let language):
            // /3/movie/{ID}/reviews
            paths += [String(id), "reviews"]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .keywords(let id):
            // /3/movie/{ID}/keywords
            paths += [String(id), "keywords"]
        case .similar(let id, let page, let language):
            // /3/movie/{ID}/similar
            paths += [String(id), "similar"]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .recommendations(let id, let page, let language):
            // /3/movie/{ID}/recommendations
            paths += [String(id), "recommendations"]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .releaseDates(let id):
            // /3/movie/{ID}/release_dates
            paths += [String(id), "release_dates"]
        case .externalIDs(let id):
            // /3/movie/{ID}/external_ids
            paths += [String(id), "external_ids"]
        case .translations(let id):
            // /3/movie/{ID}/translations
            paths += [String(id), "translations"]
        case .watchProviders(let id):
            // /3/movie/{ID}/watch/providers
            paths += [String(id), "watch", "providers"]
        case .changes(let id, let startDate, let endDate, let page):
            // /3/movie/{ID}/changes
            paths += [String(id), "changes"]
            queryItems.appendIfPresent(.startDate, value: startDate)
            queryItems.appendIfPresent(.endDate, value: endDate)
            queryItems.append(.page, value: page)
        case .latest(let language):
            // /3/movie/latest
            paths.append("latest")
            queryItems.appendIfPresent(.language, value: language)
        case .nowPlaying(let page, let language, let region):
            // /3/movie/now_playing
            paths.append("now_playing")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
            queryItems.appendIfPresent(.region, value: region)
        case .popular(let page, let language, let region):
            // /3/movie/popular
            paths.append("popular")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
            queryItems.appendIfPresent(.region, value: region)
        case .topRated(let page, let language, let region):
            // /3/movie/top_rated
            paths.append("top_rated")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
            queryItems.appendIfPresent(.region, value: region)
        case .upcoming(let page, let language, let region):
            // /3/movie/upcoming
            paths.append("upcoming")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
            queryItems.appendIfPresent(.region, value: region)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Public /3/movie/ endpoints

// MARK: Movie details

public extension TMDB {
    /// `/3/movie/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-details)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/Movie``
    /// - Throws: ``TMDBRequestError``
    static func movieDetails(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Movie>(
            endpoint: V3Endpoints.Movies.details(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Alternative Titles

public extension TMDB {
    /// `/3/movie/{id}/alternative_titles`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-alternative-titles)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: An array of ``TMDB/AlternativeTitle`` values
    /// - Throws: ``TMDBRequestError
    static func alternativeMovieTitles(id: Int) async throws(TMDBRequestError) -> [AlternativeTitle] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, AlternativeMovieTitlesResponse>(
            endpoint: V3Endpoints.Movies.alternativeTitles(id: id),
            httpMethod: .get,
        )
        do {
            let response = try await endpoint.decodedResponse()
            return response.titles
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/movie/{id}/alternative_titles`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-alternative-titles)
    /// - Parameter movie: ``TMDB/Movie``
    /// - Returns: An array of ``TMDB/AlternativeTitle`` values
    /// - Throws: ``TMDBRequestError
    static func alternativeMovieTitles(movie: Movie) async throws(TMDBRequestError) -> [AlternativeTitle] {
        try await alternativeMovieTitles(id: movie.id)
    }
}

// MARK: Movie Credits

public extension TMDB {
    /// `/3/movie/{id}/credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-credits)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/MediaCredits``
    /// - Throws: ``TMDBRequestError``
    static func movieCredits(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> MediaCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaCredits>(
            endpoint: V3Endpoints.Movies.credits(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Images

public extension TMDB {
    /// `/3/movie/{id}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-images)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/ImageCollection``
    /// - Throws: ``TMDBRequestError``
    static func movieImages(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> ImageCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ImageCollection>(
            endpoint: V3Endpoints.Movies.images(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Videos

public extension TMDB {
    /// `/3/movie/{id}/videos`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-videos)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/VideoCollection``
    /// - Throws: ``TMDBRequestError``
    static func movieVideos(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> VideoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.VideoCollection>(
            endpoint: V3Endpoints.Movies.videos(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Reviews

public extension TMDB {
    /// `/3/movie/{id}/reviews`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-reviews)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Review``
    /// - Throws: ``TMDBRequestError``
    static func movieReviews(
        id: Int,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Review> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Review>>(
            endpoint: V3Endpoints.Movies.reviews(id: id, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Keywords

public extension TMDB {
    /// `/3/movie/{id}/keywords`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-keywords)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: An array of ``TMDB/Keyword`` values
    /// - Throws: ``TMDBRequestError``
    static func movieKeywords(id: Int) async throws(TMDBRequestError) -> [Keyword] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, MovieKeywordsResponse>(
            endpoint: V3Endpoints.Movies.keywords(id: id),
            httpMethod: .get,
        )
        do {
            let response = try await endpoint.decodedResponse()
            return response.keywords
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Similar Movies

public extension TMDB {
    /// `/3/movie/{id}/similar`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-similar)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func similarMovies(
        id: Int,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.similar(id: id, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Recommendations

public extension TMDB {
    /// `/3/movie/{id}/recommendations`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-recommendations)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func movieRecommendations(
        id: Int,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.recommendations(id: id, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Release Dates

public extension TMDB {
    /// `/3/movie/{id}/release_dates`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-release-dates)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: An array of ``TMDB/ReleaseDateResult`` values
    /// - Throws: ``TMDBRequestError``
    static func movieReleaseDates(id: Int) async throws(TMDBRequestError) -> [ReleaseDateResult] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, MovieReleaseDatesResponse>(
            endpoint: V3Endpoints.Movies.releaseDates(id: id),
            httpMethod: .get,
        )
        do {
            let response = try await endpoint.decodedResponse()
            return response.results
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie External IDs

public extension TMDB {
    /// `/3/movie/{id}/external_ids`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-external-ids)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/ExternalIDs``
    /// - Throws: ``TMDBRequestError``
    static func movieExternalIDs(id: Int) async throws(TMDBRequestError) -> ExternalIDs {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ExternalIDs>(
            endpoint: V3Endpoints.Movies.externalIDs(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Translations

public extension TMDB {
    /// `/3/movie/{id}/translations`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-translations)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: An array of ``TMDB/Translation`` values
    /// - Throws: ``TMDBRequestError``
    static func movieTranslations(id: Int) async throws(TMDBRequestError) -> [Translation] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, MovieTranslationsResponse>(
            endpoint: V3Endpoints.Movies.translations(id: id),
            httpMethod: .get,
        )
        do {
            let response = try await endpoint.decodedResponse()
            return response.translations
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Watch Providers

public extension TMDB {
    /// `/3/movie/{id}/watch/providers`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-watch-providers)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/MediaWatchProviderResult``
    /// - Throws: ``TMDBRequestError``
    static func movieWatchProviders(id: Int) async throws(TMDBRequestError) -> MediaWatchProviderResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaWatchProviderResult>(
            endpoint: V3Endpoints.Movies.watchProviders(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Movie Changes

public extension TMDB {
    /// `/3/movie/{id}/changes`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-changes)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/ChangeCollection``
    /// - Throws: ``TMDBRequestError``
    static func movieChanges(
        id: Int,
        startDate: Date? = nil,
        endDate: Date? = nil,
        page: Int = 1,
    ) async throws(TMDBRequestError) -> ChangeCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ChangeCollection>(
            endpoint: V3Endpoints.Movies.changes(id: id, startDate: startDate, endDate: endDate, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Latest Movie

public extension TMDB {
    /// `/3/movie/latest`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-latest-id)
    /// - Returns: ``TMDB/Movie``
    /// - Throws: ``TMDBRequestError``
    static func latestMovie(language: Locale? = nil) async throws(TMDBRequestError) -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Movie>(
            endpoint: V3Endpoints.Movies.latest(language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Now Playing Movies

public extension TMDB {
    /// `/3/movie/now_playing`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-now-playing-list)
    /// - Returns: ``TMDB/Discover/DatedPaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func moviesNowPlaying(
        page: Int = 1,
        language: Locale? = nil,
        region: Locale.Region? = nil,
    ) async throws(TMDBRequestError) -> Discover
    .DatedPaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<
            HTTP.EmptyRequestBody,
            TMDB.Discover.DatedPaginatedResponse<TMDB.Discover.DiscoverMovie>,
        >(
            endpoint: V3Endpoints.Movies.nowPlaying(page: page, language: language, region: region),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Popular Movies

public extension TMDB {
    /// `/3/movie/popular`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-popular-list)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func popularMovies(
        page: Int = 1,
        language: Locale? = nil,
        region: Locale.Region? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.popular(page: page, language: language, region: region),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Top Rated Movies

public extension TMDB {
    /// `/3/movie/top_rated`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-top-rated-list)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func topRatedMovies(
        page: Int = 1,
        language: Locale? = nil,
        region: Locale.Region? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.topRated(page: page, language: language, region: region),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Upcoming Movies

public extension TMDB {
    /// `/3/movie/upcoming`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-upcoming-list)
    /// - Returns: ``TMDB/Discover/DatedPaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func upcomingMovies(
        page: Int = 1,
        language: Locale? = nil,
        region: Locale.Region? = nil,
    ) async throws(TMDBRequestError) -> Discover
    .DatedPaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<
            HTTP.EmptyRequestBody,
            TMDB.Discover.DatedPaginatedResponse<TMDB.Discover.DiscoverMovie>,
        >(
            endpoint: V3Endpoints.Movies.upcoming(page: page, language: language, region: region),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
