import Foundation

extension TMDB.V3Endpoints {
    enum TVSeries {
        case details(id: Int)
        case credits(id: Int)
        case aggregateCredits(id: Int)
        case images(id: Int)
        case videos(id: Int)
        case reviews(id: Int)
        case keywords(id: Int)
        case similar(id: Int)
        case recommendations(id: Int)
        case alternativeTitles(id: Int)
        case contentRatings(id: Int)
        case episodeGroups(id: Int)
        case externalIDs(id: Int)
        case translations(id: Int)
        case watchProviders(id: Int)
        case screenedTheatrically(id: Int)
        case changes(id: Int)
        case latest
        case airingToday
        case onTheAir
        case popular
        case topRated
    }
}

extension TMDB.V3Endpoints.TVSeries: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "tv"]
        switch self {
        case .details(let id):
            // /3/tv/{ID}
            paths.append(String(id))
        case .credits(let id):
            // /3/tv/{ID}/credits
            paths += [String(id), "credits"]
        case .aggregateCredits(let id):
            // /3/tv/{ID}/aggregate_credits
            paths += [String(id), "aggregate_credits"]
        case .images(let id):
            // /3/tv/{ID}/images
            paths += [String(id), "images"]
        case .videos(let id):
            // /3/tv/{ID}/videos
            paths += [String(id), "videos"]
        case .reviews(let id):
            // /3/tv/{ID}/reviews
            paths += [String(id), "reviews"]
        case .keywords(let id):
            // /3/tv/{ID}/keywords
            paths += [String(id), "keywords"]
        case .similar(let id):
            // /3/tv/{ID}/similar
            paths += [String(id), "similar"]
        case .recommendations(let id):
            // /3/tv/{ID}/recommendations
            paths += [String(id), "recommendations"]
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
        case .changes(let id):
            // /3/tv/{ID}/changes
            paths += [String(id), "changes"]
        case .latest:
            // /3/tv/latest
            paths.append("latest")
        case .airingToday:
            // /3/tv/airing_today
            paths.append("airing_today")
        case .onTheAir:
            // /3/tv/on_the_air
            paths.append("on_the_air")
        case .popular:
            // /3/tv/popular
            paths.append("popular")
        case .topRated:
            // /3/tv/top_rated
            paths.append("top_rated")
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: - Public /3/tv/ endpoints

// MARK: TV Series Details

public extension TMDB {
    /// `/3/tv/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-series-details)
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/TVSeries``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesDetails(id: Int) async throws(TMDBRequestError) -> TVSeries {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TVSeries>(
            endpoint: V3Endpoints.TVSeries.details(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/MediaCredits``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesCredits(id: Int) async throws(TMDBRequestError) -> MediaCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaCredits>(
            endpoint: V3Endpoints.TVSeries.credits(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/AggregateCredits``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesAggregateCredits(id: Int) async throws(TMDBRequestError) -> AggregateCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.AggregateCredits>(
            endpoint: V3Endpoints.TVSeries.aggregateCredits(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/ImageCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesImages(id: Int) async throws(TMDBRequestError) -> ImageCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ImageCollection>(
            endpoint: V3Endpoints.TVSeries.images(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/VideoCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesVideos(id: Int) async throws(TMDBRequestError) -> VideoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.VideoCollection>(
            endpoint: V3Endpoints.TVSeries.videos(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Review``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesReviews(id: Int) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Review> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Review>>(
            endpoint: V3Endpoints.TVSeries.reviews(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func similarTVSeries(id: Int) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.similar(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesRecommendations(id: Int) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.recommendations(id: id),
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
    /// - Parameter id: `Int` TMDB's unique identifier for the TV series
    /// - Returns: ``TMDB/ChangeCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesChanges(id: Int) async throws(TMDBRequestError) -> ChangeCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ChangeCollection>(
            endpoint: V3Endpoints.TVSeries.changes(id: id),
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
    /// - Returns: ``TMDB/TVSeries``
    /// - Throws: ``TMDBRequestError``
    static func latestTVSeries() async throws(TMDBRequestError) -> TVSeries {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TVSeries>(
            endpoint: V3Endpoints.TVSeries.latest,
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
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesAiringToday() async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.airingToday,
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
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func tvSeriesOnTheAir() async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.onTheAir,
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
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func popularTVSeries() async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.popular,
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
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func topRatedTVSeries() async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.TVSeries.topRated,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
