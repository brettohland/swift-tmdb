import Foundation

extension TMDB.V3Endpoints {
    enum TVSeries {
        case details(id: Int, language: Locale?)
        case credits(id: Int, language: Locale?)
        case aggregateCredits(id: Int, language: Locale?)
        case images(id: Int, language: Locale?)
        case videos(id: Int, language: Locale?)
        case reviews(id: Int, page: Int, language: Locale?)
        case keywords(id: Int)
        case similar(id: Int, page: Int, language: Locale?)
        case recommendations(id: Int, page: Int, language: Locale?)
        case alternativeTitles(id: Int)
        case contentRatings(id: Int)
        case episodeGroups(id: Int)
        case externalIDs(id: Int)
        case translations(id: Int)
        case watchProviders(id: Int)
        case screenedTheatrically(id: Int)
        case changes(id: Int, startDate: Date?, endDate: Date?, page: Int)
        case latest(language: Locale?)
        case airingToday(page: Int, language: Locale?)
        case onTheAir(page: Int, language: Locale?)
        case popular(page: Int, language: Locale?, region: Locale.Region?)
        case topRated(page: Int, language: Locale?)
    }
}

extension TMDB.V3Endpoints.TVSeries: EndpointFactory {
    var supportsLanguage: Bool {
        switch self {
        case .alternativeTitles,
             .changes,
             .contentRatings,
             .episodeGroups,
             .externalIDs,
             .keywords,
             .screenedTheatrically,
             .translations,
             .watchProviders:
            false
        default:
            true
        }
    }

    var supportsRegion: Bool {
        switch self {
        case .popular:
            true
        default:
            false
        }
    }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "tv"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let id, let language):
            // /3/tv/{ID}
            paths.append(String(id))
            queryItems.appendIfPresent(.language, value: language)
        case .credits(let id, let language):
            // /3/tv/{ID}/credits
            paths += [String(id), "credits"]
            queryItems.appendIfPresent(.language, value: language)
        case .aggregateCredits(let id, let language):
            // /3/tv/{ID}/aggregate_credits
            paths += [String(id), "aggregate_credits"]
            queryItems.appendIfPresent(.language, value: language)
        case .images(let id, let language):
            // /3/tv/{ID}/images
            paths += [String(id), "images"]
            queryItems.appendIfPresent(.language, value: language)
        case .videos(let id, let language):
            // /3/tv/{ID}/videos
            paths += [String(id), "videos"]
            queryItems.appendIfPresent(.language, value: language)
        case .reviews(let id, let page, let language):
            // /3/tv/{ID}/reviews
            paths += [String(id), "reviews"]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .keywords(let id):
            // /3/tv/{ID}/keywords
            paths += [String(id), "keywords"]
        case .similar(let id, let page, let language):
            // /3/tv/{ID}/similar
            paths += [String(id), "similar"]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .recommendations(let id, let page, let language):
            // /3/tv/{ID}/recommendations
            paths += [String(id), "recommendations"]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .alternativeTitles(let id):
            // /3/tv/{ID}/alternative_titles
            paths += [String(id), "alternative_titles"]
        case .contentRatings(let id):
            // /3/tv/{ID}/content_ratings
            paths += [String(id), "content_ratings"]
        case .episodeGroups(let id):
            // /3/tv/{ID}/episode_groups
            paths += [String(id), "episode_groups"]
        case .externalIDs(let id):
            // /3/tv/{ID}/external_ids
            paths += [String(id), "external_ids"]
        case .translations(let id):
            // /3/tv/{ID}/translations
            paths += [String(id), "translations"]
        case .watchProviders(let id):
            // /3/tv/{ID}/watch/providers
            paths += [String(id), "watch", "providers"]
        case .screenedTheatrically(let id):
            // /3/tv/{ID}/screened_theatrically
            paths += [String(id), "screened_theatrically"]
        case .changes(let id, let startDate, let endDate, let page):
            // /3/tv/{ID}/changes
            paths += [String(id), "changes"]
            queryItems.appendIfPresent(.startDate, value: startDate)
            queryItems.appendIfPresent(.endDate, value: endDate)
            queryItems.append(.page, value: page)
        case .latest(let language):
            // /3/tv/latest
            paths.append("latest")
            queryItems.appendIfPresent(.language, value: language)
        case .airingToday(let page, let language):
            // /3/tv/airing_today
            paths.append("airing_today")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .onTheAir(let page, let language):
            // /3/tv/on_the_air
            paths.append("on_the_air")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .popular(let page, let language, let region):
            // /3/tv/popular
            paths.append("popular")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
            queryItems.appendIfPresent(.region, value: region)
        case .topRated(let page, let language):
            // /3/tv/top_rated
            paths.append("top_rated")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Public /3/tv/ endpoints

// MARK: TV Series Details

public extension TMDB {
    /// `/3/tv/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-details)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/TVSeries``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesDetails(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> TVSeries {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TVSeries>(
            endpoint: V3Endpoints.TVSeries.details(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Credits

public extension TMDB {
    /// `/3/tv/{id}/credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-credits)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/MediaCredits``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesCredits(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> MediaCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaCredits>(
            endpoint: V3Endpoints.TVSeries.credits(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Aggregate Credits

public extension TMDB {
    /// `/3/tv/{id}/aggregate_credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-aggregate-credits)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/AggregateCredits``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesAggregateCredits(id: Int, language: Locale? = nil) async throws(TMDBRequestError)
        -> AggregateCredits
    {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.AggregateCredits>(
            endpoint: V3Endpoints.TVSeries.aggregateCredits(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Images

public extension TMDB {
    /// `/3/tv/{id}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-images)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/ImageCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesImages(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> ImageCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ImageCollection>(
            endpoint: V3Endpoints.TVSeries.images(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Videos

public extension TMDB {
    /// `/3/tv/{id}/videos`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-videos)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/VideoCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesVideos(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> VideoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.VideoCollection>(
            endpoint: V3Endpoints.TVSeries.videos(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Reviews

public extension TMDB {
    /// `/3/tv/{id}/reviews`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-reviews)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - page: The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Review``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesReviews(
        id: Int,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Review> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Review>>(
            endpoint: V3Endpoints.TVSeries.reviews(id: id, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Keywords

public extension TMDB {
    /// `/3/tv/{id}/keywords`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-keywords)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: An array of ``TMDB/Keyword`` values
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesKeywords(id: Int) async throws(TMDBRequestError) -> [Keyword] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TVSeriesKeywordsResponse>(
            endpoint: V3Endpoints.TVSeries.keywords(id: id),
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

// MARK: Similar TV Series

public extension TMDB {
    /// `/3/tv/{id}/similar`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-similar)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - page: The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func similarTVSeries(
        id: Int,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.similar(id: id, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Recommendations

public extension TMDB {
    /// `/3/tv/{id}/recommendations`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-recommendations)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - page: The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesRecommendations(
        id: Int,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.recommendations(id: id, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Alternative TV Series Titles

public extension TMDB {
    /// `/3/tv/{id}/alternative_titles`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-alternative-titles)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: An array of ``TMDB/AlternativeTitle`` values
    /// - Throws: ``TMDBRequestError``
    static func alternativeTVSeriesTitles(id: Int) async throws(TMDBRequestError) -> [AlternativeTitle] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TVSeriesAlternativeTitlesResponse>(
            endpoint: V3Endpoints.TVSeries.alternativeTitles(id: id),
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

// MARK: TV Series Content Ratings

public extension TMDB {
    /// `/3/tv/{id}/content_ratings`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-content-ratings)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: An array of ``TMDB/ContentRating`` values
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesContentRatings(id: Int) async throws(TMDBRequestError) -> [ContentRating] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, ContentRatingResponse>(
            endpoint: V3Endpoints.TVSeries.contentRatings(id: id),
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

// MARK: TV Series Episode Groups

public extension TMDB {
    /// `/3/tv/{id}/episode_groups`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-episode-groups)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: An array of ``TMDB/EpisodeGroup`` values
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesEpisodeGroups(id: Int) async throws(TMDBRequestError) -> [EpisodeGroup] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, EpisodeGroupsResponse>(
            endpoint: V3Endpoints.TVSeries.episodeGroups(id: id),
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

// MARK: TV Series External IDs

public extension TMDB {
    /// `/3/tv/{id}/external_ids`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-external-ids)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/ExternalIDs``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesExternalIDs(id: Int) async throws(TMDBRequestError) -> ExternalIDs {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ExternalIDs>(
            endpoint: V3Endpoints.TVSeries.externalIDs(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Translations

public extension TMDB {
    /// `/3/tv/{id}/translations`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-translations)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: An array of ``TMDB/Translation`` values
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesTranslations(id: Int) async throws(TMDBRequestError) -> [Translation] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TVSeriesTranslationsResponse>(
            endpoint: V3Endpoints.TVSeries.translations(id: id),
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

// MARK: TV Series Watch Providers

public extension TMDB {
    /// `/3/tv/{id}/watch/providers`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-watch-providers)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/MediaWatchProviderResult``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesWatchProviders(id: Int) async throws(TMDBRequestError) -> MediaWatchProviderResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaWatchProviderResult>(
            endpoint: V3Endpoints.TVSeries.watchProviders(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Screened Theatrically

public extension TMDB {
    /// `/3/tv/{id}/screened_theatrically`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-screened-theatrically)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: An array of ``TMDB/ScreenedTheatricallyResult`` values
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesScreenedTheatrically(id: Int) async throws(TMDBRequestError) -> [ScreenedTheatricallyResult] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, ScreenedTheatricallyResponse>(
            endpoint: V3Endpoints.TVSeries.screenedTheatrically(id: id),
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

// MARK: TV Series Changes

public extension TMDB {
    /// `/3/tv/{id}/changes`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-changes)
    /// - Parameters:
    ///   - id: `Int` TMDB's unique identifier for the TV series
    ///   - startDate: Filter changes from this date
    ///   - endDate: Filter changes to this date
    ///   - page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/ChangeCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesChanges(
        id: Int,
        startDate: Date? = nil,
        endDate: Date? = nil,
        page: Int = 1,
    ) async throws(TMDBRequestError) -> ChangeCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ChangeCollection>(
            endpoint: V3Endpoints.TVSeries.changes(id: id, startDate: startDate, endDate: endDate, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Latest TV Series

public extension TMDB {
    /// `/3/tv/latest`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-latest-id)
    /// - Parameter language: Override the default language for this request
    /// - Returns: ``TMDB/TVSeries``
    /// - Throws: ``TMDBRequestError``
    static func latestTVSeries(language: Locale? = nil) async throws(TMDBRequestError) -> TVSeries {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TVSeries>(
            endpoint: V3Endpoints.TVSeries.latest(language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series Airing Today

public extension TMDB {
    /// `/3/tv/airing_today`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-airing-today-list)
    /// - Parameters:
    ///   - page: The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesAiringToday(
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.airingToday(page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Series On The Air

public extension TMDB {
    /// `/3/tv/on_the_air`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-on-the-air-list)
    /// - Parameters:
    ///   - page: The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesOnTheAir(
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.onTheAir(page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Popular TV Series

public extension TMDB {
    /// `/3/tv/popular`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-popular-list)
    /// - Parameters:
    ///   - page: The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    ///   - region: Override the default region for this request
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func popularTVSeries(
        page: Int = 1,
        language: Locale? = nil,
        region: Locale.Region? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.popular(page: page, language: language, region: region),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Top Rated TV Series

public extension TMDB {
    /// `/3/tv/top_rated`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-top-rated-list)
    /// - Parameters:
    ///   - page: The page of results to return (default: 1)
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func topRatedTVSeries(
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.topRated(page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
