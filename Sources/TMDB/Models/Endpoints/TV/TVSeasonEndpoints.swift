import Foundation

extension TMDB.V3Endpoints {
    enum TVSeasons {
        case details(seriesID: Int, seasonNumber: Int)
        case credits(seriesID: Int, seasonNumber: Int)
        case aggregateCredits(seriesID: Int, seasonNumber: Int)
        case externalIDs(seriesID: Int, seasonNumber: Int)
        case images(seriesID: Int, seasonNumber: Int)
        case translations(seriesID: Int, seasonNumber: Int)
        case videos(seriesID: Int, seasonNumber: Int)
        case watchProviders(seriesID: Int, seasonNumber: Int)
        case changes(seasonID: Int)
    }
}

extension TMDB.V3Endpoints.TVSeasons: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "tv"]
        switch self {
        case .details(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}
            paths += [String(seriesID), "season", String(seasonNumber)]
        case .credits(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}/credits
            paths += [String(seriesID), "season", String(seasonNumber), "credits"]
        case .aggregateCredits(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}/aggregate_credits
            paths += [String(seriesID), "season", String(seasonNumber), "aggregate_credits"]
        case .externalIDs(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}/external_ids
            paths += [String(seriesID), "season", String(seasonNumber), "external_ids"]
        case .images(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}/images
            paths += [String(seriesID), "season", String(seasonNumber), "images"]
        case .translations(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}/translations
            paths += [String(seriesID), "season", String(seasonNumber), "translations"]
        case .videos(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}/videos
            paths += [String(seriesID), "season", String(seasonNumber), "videos"]
        case .watchProviders(let seriesID, let seasonNumber):
            // /3/tv/{ID}/season/{SEASON}/watch/providers
            paths += [String(seriesID), "season", String(seasonNumber), "watch", "providers"]
        case .changes(let seasonID):
            // /3/tv/season/{SEASON_ID}/changes
            paths += ["season", String(seasonID), "changes"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: - Public /3/tv/{id}/season/ endpoints

// MARK: TV Season Details

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-details)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: ``TMDB/TVSeason``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonDetails(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError) -> TVSeason {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TVSeason>(
            endpoint: V3Endpoints.TVSeasons.details(seriesID: seriesID, seasonNumber: seasonNumber),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Season Credits

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-credits)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: ``TMDB/MediaCredits``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonCredits(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError) -> MediaCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaCredits>(
            endpoint: V3Endpoints.TVSeasons.credits(seriesID: seriesID, seasonNumber: seasonNumber),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Season Aggregate Credits

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/aggregate_credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-aggregate-credits)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: ``TMDB/AggregateCredits``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonAggregateCredits(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError)
        -> AggregateCredits
    {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.AggregateCredits>(
            endpoint: V3Endpoints.TVSeasons.aggregateCredits(seriesID: seriesID, seasonNumber: seasonNumber),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Season External IDs

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/external_ids`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-external-ids)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: ``TMDB/ExternalIDs``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonExternalIDs(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError) -> ExternalIDs {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ExternalIDs>(
            endpoint: V3Endpoints.TVSeasons.externalIDs(seriesID: seriesID, seasonNumber: seasonNumber),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Season Images

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-images)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: ``TMDB/ImageCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonImages(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError) -> ImageCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ImageCollection>(
            endpoint: V3Endpoints.TVSeasons.images(seriesID: seriesID, seasonNumber: seasonNumber),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Season Translations

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/translations`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-translations)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: An array of ``TMDB/Translation`` values
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonTranslations(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError) -> [Translation] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TVSeriesTranslationsResponse>(
            endpoint: V3Endpoints.TVSeasons.translations(seriesID: seriesID, seasonNumber: seasonNumber),
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

// MARK: TV Season Videos

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/videos`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-videos)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: ``TMDB/VideoCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonVideos(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError) -> VideoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.VideoCollection>(
            endpoint: V3Endpoints.TVSeasons.videos(seriesID: seriesID, seasonNumber: seasonNumber),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Season Watch Providers

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/watch/providers`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-watch-providers)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    /// - Returns: ``TMDB/MediaWatchProviderResult``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonWatchProviders(seriesID: Int, seasonNumber: Int) async throws(TMDBRequestError)
        -> MediaWatchProviderResult
    {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaWatchProviderResult>(
            endpoint: V3Endpoints.TVSeasons.watchProviders(seriesID: seriesID, seasonNumber: seasonNumber),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: TV Season Changes

public extension TMDB {
    /// `/3/tv/season/{season_id}/changes`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-season-changes-by-id)
    /// - Parameter seasonID: `Int` TMDB's unique identifier for the TV season
    /// - Returns: ``TMDB/ChangeCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvSeasonChanges(seasonID: Int) async throws(TMDBRequestError) -> ChangeCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ChangeCollection>(
            endpoint: V3Endpoints.TVSeasons.changes(seasonID: seasonID),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
