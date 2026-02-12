import Foundation

extension TMDB.V3Endpoints {
    enum Movies {
        case details(id: Int)
        case alternativeTitles(id: Int)
        case credits(id: Int)
        case images(id: Int)
        case videos(id: Int)
        case reviews(id: Int)
        case keywords(id: Int)
        case similar(id: Int)
        case recommendations(id: Int)
        case releaseDates(id: Int)
        case externalIDs(id: Int)
        case translations(id: Int)
        case watchProviders(id: Int)
        case changes(id: Int)
        case latest
        case nowPlaying
        case popular
        case topRated
        case upcoming
    }
}

extension TMDB.V3Endpoints.Movies: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "movie"]
        switch self {
        case .details(let id):
            // /3/movie/{ID}
            paths.append(String(id))
        case .alternativeTitles(let id):
            // /3/movie/{ID}/alternative_titles
            paths += [String(id), "alternative_titles"]
        case .credits(let id):
            // /3/movie/{ID}/credits
            paths += [String(id), "credits"]
        case .images(let id):
            // /3/movie/{ID}/images
            paths += [String(id), "images"]
        case .videos(let id):
            // /3/movie/{ID}/videos
            paths += [String(id), "videos"]
        case .reviews(let id):
            // /3/movie/{ID}/reviews
            paths += [String(id), "reviews"]
        case .keywords(let id):
            // /3/movie/{ID}/keywords
            paths += [String(id), "keywords"]
        case .similar(let id):
            // /3/movie/{ID}/similar
            paths += [String(id), "similar"]
        case .recommendations(let id):
            // /3/movie/{ID}/recommendations
            paths += [String(id), "recommendations"]
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
        case .changes(let id):
            // /3/movie/{ID}/changes
            paths += [String(id), "changes"]
        case .latest:
            // /3/movie/latest
            paths.append("latest")
        case .nowPlaying:
            // /3/movie/now_playing
            paths.append("now_playing")
        case .popular:
            // /3/movie/popular
            paths.append("popular")
        case .topRated:
            // /3/movie/top_rated
            paths.append("top_rated")
        case .upcoming:
            // /3/movie/upcoming
            paths.append("upcoming")
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
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
    static func movieDetails(id: Int) async throws(TMDBRequestError) -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Movie>(
            endpoint: V3Endpoints.Movies.details(id: id),
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
    static func movieCredits(id: Int) async throws(TMDBRequestError) -> MediaCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaCredits>(
            endpoint: V3Endpoints.Movies.credits(id: id),
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
    static func movieImages(id: Int) async throws(TMDBRequestError) -> ImageCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ImageCollection>(
            endpoint: V3Endpoints.Movies.images(id: id),
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
    static func movieVideos(id: Int) async throws(TMDBRequestError) -> VideoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.VideoCollection>(
            endpoint: V3Endpoints.Movies.videos(id: id),
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
    static func movieReviews(id: Int) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Review> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Review>>(
            endpoint: V3Endpoints.Movies.reviews(id: id),
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
    static func similarMovies(id: Int) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.similar(id: id),
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
    static func movieRecommendations(id: Int) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.recommendations(id: id),
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
    static func movieChanges(id: Int) async throws(TMDBRequestError) -> ChangeCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ChangeCollection>(
            endpoint: V3Endpoints.Movies.changes(id: id),
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
    static func latestMovie() async throws(TMDBRequestError) -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Movie>(
            endpoint: V3Endpoints.Movies.latest,
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
    static func moviesNowPlaying() async throws(TMDBRequestError) -> Discover
    .DatedPaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<
            HTTP.EmptyRequestBody,
            TMDB.Discover.DatedPaginatedResponse<TMDB.Discover.DiscoverMovie>,
        >(
            endpoint: V3Endpoints.Movies.nowPlaying,
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
    static func popularMovies() async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.popular,
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
    static func topRatedMovies() async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Movies.topRated,
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
    static func upcomingMovies() async throws(TMDBRequestError) -> Discover
    .DatedPaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<
            HTTP.EmptyRequestBody,
            TMDB.Discover.DatedPaginatedResponse<TMDB.Discover.DiscoverMovie>,
        >(
            endpoint: V3Endpoints.Movies.upcoming,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
