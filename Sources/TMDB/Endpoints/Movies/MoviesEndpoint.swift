import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints {
    enum Movies {
        case details(id: Int)
        case alternativeTitles(id: Int)
    }
}

extension TMDBInternal.V3Endpoints.Movies: EndpointFactory {
    public func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "movie"]
        switch self {
        case .details(let id):
            paths.append(String(id))
        case .alternativeTitles(let id):
            paths += [String(id), "alternative_titles"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB.Client {
    enum Movie {
        static func details(id: Int) async throws -> TMDBInternal.Movie.Details {
            let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Movie.Details>(
                endpoint: TMDBInternal.V3Endpoints.Movies.details(id: id),
                httpMethod: .get,
            )
            return try await endpoint.decodedResponse()
        }

        static func alternativeTitles(id: Int) async throws -> TMDBInternal.Movie.AlternativeTitle {
            let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Movie.AlternativeTitle>(
                endpoint: TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: id),
                httpMethod: .get,
            )
            return try await endpoint.decodedResponse()
        }
    }
}
