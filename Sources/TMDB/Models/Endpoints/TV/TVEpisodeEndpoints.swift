import Foundation

extension TMDB.V3Endpoints {
    enum TVEpisodes {
        case details(seriesID: Int, seasonNumber: Int, episodeNumber: Int, language: Locale?)
        case credits(seriesID: Int, seasonNumber: Int, episodeNumber: Int, language: Locale?)
        case externalIDs(seriesID: Int, seasonNumber: Int, episodeNumber: Int)
        case images(seriesID: Int, seasonNumber: Int, episodeNumber: Int, language: Locale?)
        case translations(seriesID: Int, seasonNumber: Int, episodeNumber: Int)
        case videos(seriesID: Int, seasonNumber: Int, episodeNumber: Int, language: Locale?)
        case changes(episodeID: Int, startDate: Date?, endDate: Date?, page: Int)
    }
}

extension TMDB.V3Endpoints.TVEpisodes: EndpointFactory {
    var supportsLanguage: Bool {
        switch self {
        case .changes,
             .externalIDs,
             .translations:
            false
        default:
            true
        }
    }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "tv"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let seriesID, let seasonNumber, let episodeNumber, let language):
            // /3/tv/{ID}/season/{SEASON}/episode/{EPISODE}
            paths += [String(seriesID), "season", String(seasonNumber), "episode", String(episodeNumber)]
            queryItems.appendIfPresent(.language, value: language)
        case .credits(let seriesID, let seasonNumber, let episodeNumber, let language):
            // /3/tv/{ID}/season/{SEASON}/episode/{EPISODE}/credits
            paths += [String(seriesID), "season", String(seasonNumber), "episode", String(episodeNumber), "credits"]
            queryItems.appendIfPresent(.language, value: language)
        case .externalIDs(let seriesID, let seasonNumber, let episodeNumber):
            // /3/tv/{ID}/season/{SEASON}/episode/{EPISODE}/external_ids
            paths += [
                String(seriesID), "season", String(seasonNumber), "episode", String(episodeNumber), "external_ids",
            ]
        case .images(let seriesID, let seasonNumber, let episodeNumber, let language):
            // /3/tv/{ID}/season/{SEASON}/episode/{EPISODE}/images
            paths += [String(seriesID), "season", String(seasonNumber), "episode", String(episodeNumber), "images"]
            queryItems.appendIfPresent(.language, value: language)
        case .translations(let seriesID, let seasonNumber, let episodeNumber):
            // /3/tv/{ID}/season/{SEASON}/episode/{EPISODE}/translations
            paths += [
                String(seriesID), "season", String(seasonNumber), "episode", String(episodeNumber), "translations",
            ]
        case .videos(let seriesID, let seasonNumber, let episodeNumber, let language):
            // /3/tv/{ID}/season/{SEASON}/episode/{EPISODE}/videos
            paths += [String(seriesID), "season", String(seasonNumber), "episode", String(episodeNumber), "videos"]
            queryItems.appendIfPresent(.language, value: language)
        case .changes(let episodeID, let startDate, let endDate, let page):
            // /3/tv/episode/{EPISODE_ID}/changes
            paths += ["episode", String(episodeID), "changes"]
            queryItems.appendIfPresent(.startDate, value: startDate)
            queryItems.appendIfPresent(.endDate, value: endDate)
            queryItems.append(.page, value: page)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Public /3/tv/{id}/season/{season}/episode/ endpoints

// MARK: TV Episode Details

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/episode/{episode_number}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-details)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    ///   - episodeNumber: `Int` The episode number
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/TVEpisode``
    /// - Throws: ``TMDBRequestError``
    static func tvEpisodeDetails(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> TVEpisode {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TVEpisode>(
            endpoint: V3Endpoints.TVEpisodes.details(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
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

// MARK: TV Episode Credits

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/episode/{episode_number}/credits`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-credits)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    ///   - episodeNumber: `Int` The episode number
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/MediaCredits``
    /// - Throws: ``TMDBRequestError``
    static func tvEpisodeCredits(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> MediaCredits {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MediaCredits>(
            endpoint: V3Endpoints.TVEpisodes.credits(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
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

// MARK: TV Episode External IDs

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/episode/{episode_number}/external_ids`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-external-ids)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    ///   - episodeNumber: `Int` The episode number
    /// - Returns: ``TMDB/ExternalIDs``
    /// - Throws: ``TMDBRequestError``
    static func tvEpisodeExternalIDs(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
    ) async throws(TMDBRequestError) -> ExternalIDs {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ExternalIDs>(
            endpoint: V3Endpoints.TVEpisodes.externalIDs(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
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

// MARK: TV Episode Images

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/episode/{episode_number}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-images)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    ///   - episodeNumber: `Int` The episode number
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/ImageCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvEpisodeImages(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> ImageCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ImageCollection>(
            endpoint: V3Endpoints.TVEpisodes.images(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
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

// MARK: TV Episode Translations

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/episode/{episode_number}/translations`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-translations)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    ///   - episodeNumber: `Int` The episode number
    /// - Returns: An array of ``TMDB/Translation`` values
    /// - Throws: ``TMDBRequestError``
    static func tvEpisodeTranslations(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
    ) async throws(TMDBRequestError) -> [Translation] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TVSeriesTranslationsResponse>(
            endpoint: V3Endpoints.TVEpisodes.translations(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
            ),
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

// MARK: TV Episode Videos

public extension TMDB {
    /// `/3/tv/{id}/season/{season_number}/episode/{episode_number}/videos`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-videos)
    /// - Parameters:
    ///   - seriesID: `Int` TMDB's unique identifier for the TV series
    ///   - seasonNumber: `Int` The season number
    ///   - episodeNumber: `Int` The episode number
    ///   - language: Override the default language for this request
    /// - Returns: ``TMDB/VideoCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvEpisodeVideos(
        seriesID: Int,
        seasonNumber: Int,
        episodeNumber: Int,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> VideoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.VideoCollection>(
            endpoint: V3Endpoints.TVEpisodes.videos(
                seriesID: seriesID,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
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

// MARK: TV Episode Changes

public extension TMDB {
    /// `/3/tv/episode/{episode_id}/changes`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-changes-by-id)
    /// - Parameters:
    ///   - episodeID: `Int` TMDB's unique identifier for the TV episode
    ///   - startDate: Filter changes from this date
    ///   - endDate: Filter changes to this date
    ///   - page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/ChangeCollection``
    /// - Throws: ``TMDBRequestError``
    static func tvEpisodeChanges(
        episodeID: Int,
        startDate: Date? = nil,
        endDate: Date? = nil,
        page: Int = 1,
    ) async throws(TMDBRequestError) -> ChangeCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ChangeCollection>(
            endpoint: V3Endpoints.TVEpisodes.changes(
                episodeID: episodeID,
                startDate: startDate,
                endDate: endDate,
                page: page,
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
