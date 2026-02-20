import Foundation

extension TMDB.V3Endpoints {
    enum Networks {
        case details(id: Int)
        case images(id: Int)
    }
}

extension TMDB.V3Endpoints.Networks: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "network"]
        switch self {
        case .details(let id):
            // /3/network/{id}
            paths.append(String(id))
        case .images(let id):
            // /3/network/{id}/images
            paths += [String(id), "images"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: - Public /3/network/ endpoints

// MARK: Network Details

public extension TMDB {
    /// `/3/network/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/network-details)
    /// - Parameter id: `Int` TMDB's unique identifier for the network
    /// - Returns: ``TMDB/Network``
    /// - Throws: ``TMDBRequestError``
    static func networkDetails(id: Int) async throws(TMDBRequestError) -> Network {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Network>(
            endpoint: V3Endpoints.Networks.details(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Network Images

public extension TMDB {
    /// `/3/network/{id}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/network-images)
    /// - Parameter id: `Int` TMDB's unique identifier for the network
    /// - Returns: ``TMDB/LogoCollection``
    /// - Throws: ``TMDBRequestError``
    static func networkImages(id: Int) async throws(TMDBRequestError) -> LogoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.LogoCollection>(
            endpoint: V3Endpoints.Networks.images(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
