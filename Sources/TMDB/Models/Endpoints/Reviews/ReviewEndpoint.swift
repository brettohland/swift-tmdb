import Foundation

extension TMDB.V3Endpoints {
    enum Reviews {
        case details(id: String)
    }
}

extension TMDB.V3Endpoints.Reviews: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "review"]
        switch self {
        case .details(let id):
            // /3/review/{ID}
            paths.append(id)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: - Public /3/review/ endpoints

// MARK: Review Details

public extension TMDB {
    /// `/3/review/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/review-details)
    /// - Parameter id: `String` TMDB's unique identifier for the review
    /// - Returns: ``TMDB/Review``
    /// - Throws: ``TMDBRequestError``
    static func reviewDetails(id: String) async throws(TMDBRequestError) -> Review {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Review>(
            endpoint: V3Endpoints.Reviews.details(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
