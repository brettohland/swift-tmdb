import Foundation

// MARK: - External Source

public extension TMDB {
    /// The external source to search by when using the find endpoint
    enum ExternalSource: String, Sendable {
        case imdbID = "imdb_id"
        case tvdbID = "tvdb_id"
        case freebaseMID = "freebase_mid"
        case freebaseID = "freebase_id"
        case tvrageID = "tvrage_id"
        case facebookID = "facebook_id"
        case twitterID = "twitter_id"
        case instagramID = "instagram_id"
    }
}

// MARK: - Endpoint

extension TMDB.V3Endpoints {
    enum Find {
        case byID(externalID: String, source: TMDB.ExternalSource, language: Locale?)
    }
}

extension TMDB.V3Endpoints.Find: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        switch self {
        case .byID(let externalID, let source, let language):
            // /3/find/{external_id}?external_source=...
            let paths: [any StringProtocol] = ["3", "find", externalID]
            var queryItems: [URLQueryItem] = []
            queryItems.append("external_source", value: source.rawValue)
            queryItems.appendIfPresent(.language, value: language)
            return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
        }
    }
}

// MARK: - Find by External ID

public extension TMDB {
    /// `/3/find/{external_id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/find-by-id)
    /// - Parameters:
    ///   - externalID: The external ID to search for
    ///   - source: The ``TMDB/ExternalSource`` to search by
    ///   - language: The locale for translated content
    /// - Returns: ``TMDB/FindResult``
    /// - Throws: ``TMDBRequestError``
    static func find(
        externalID: String,
        source: ExternalSource,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> FindResult {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.FindResult>(
            endpoint: V3Endpoints.Find.byID(externalID: externalID, source: source, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
