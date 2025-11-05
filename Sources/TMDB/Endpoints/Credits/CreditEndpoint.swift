import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints {
    enum Credits {
        case details(id: Int)
    }
}

extension TMDBInternal.V3Endpoints.Credits: EndpointFactory {
    public func makeURL(baseURL: URL) -> URL {
        var paths: [String] = []
        switch self {
        case .details(id: let id):
            paths += ["credit", String(id)]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }

}

extension TMDB.Client {
    enum Credits {
        static func credits(id: Int) async throws -> TMDBInternal.Credits.Details {
            let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Credits.Details>(
                endpoint: TMDBInternal.V3Endpoints.Credits.details(id: id),
                httpMethod: .get,
            )
            return try await endpoint.decodedResponse()
        }
    }
}
