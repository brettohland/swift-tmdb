import Foundation

extension TMDB.V3Endpoints {
    enum Collections {
        case details(id: Int, language: Locale?)
        case images(id: Int, language: Locale?)
    }
}

extension TMDB.V3Endpoints.Collections: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "collection"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let id, let language):
            // /3/collection/{id}
            paths.append(String(id))
            queryItems.appendIfPresent(.language, value: language)
        case .images(let id, let language):
            // /3/collection/{id}/images
            paths += [String(id), "images"]
            queryItems.appendIfPresent(.language, value: language)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Collection Details

public extension TMDB {
    /// `/3/collection/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/collection-details)
    /// - Parameter id: The collection ID
    /// - Returns: ``TMDB/Collection``
    /// - Throws: ``TMDBRequestError``
    static func collectionDetails(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> Collection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Collection>(
            endpoint: V3Endpoints.Collections.details(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Collection Images

public extension TMDB {
    /// `/3/collection/{id}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/collection-images)
    /// - Parameter id: The collection ID
    /// - Returns: ``TMDB/ImageCollection``
    /// - Throws: ``TMDBRequestError``
    static func collectionImages(id: Int, language: Locale? = nil) async throws(TMDBRequestError) -> ImageCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ImageCollection>(
            endpoint: V3Endpoints.Collections.images(id: id, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
