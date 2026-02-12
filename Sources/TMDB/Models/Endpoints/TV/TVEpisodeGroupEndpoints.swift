import Foundation

extension TMDB.V3Endpoints {
    enum TVEpisodeGroups {
        case details(id: String)
    }
}

extension TMDB.V3Endpoints.TVEpisodeGroups: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "tv", "episode_group"]
        switch self {
        case .details(let id):
            // /3/tv/episode_group/{ID}
            paths.append(id)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: - Public /3/tv/episode_group/ endpoints

// MARK: Episode Group Details

public extension TMDB {
    /// `/3/tv/episode_group/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/tv-episode-group-details)
    /// - Parameter id: `String` TMDB's unique identifier for the episode group
    /// - Returns: ``TMDB/EpisodeGroupDetails``
    /// - Throws: ``TMDBRequestError``
    static func episodeGroupDetails(id: String) async throws(TMDBRequestError) -> EpisodeGroupDetails {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.EpisodeGroupDetails>(
            endpoint: V3Endpoints.TVEpisodeGroups.details(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
