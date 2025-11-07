import Foundation

extension TMDB.V3Endpoints {
    enum Credits {
        case details(id: Int)
    }
}

extension TMDB.V3Endpoints.Credits: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [String] = []
        switch self {
        case .details(id: let id):
            paths += ["credit", String(id)]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }

}

extension TMDB {
    static func credits(forID id: Int) async throws -> TMDB.Credits.Details {
        let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDB.Credits.Details>(
            endpoint: TMDB.V3Endpoints.Credits.details(id: id),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    static func credits(forMovie movie: Movie) async throws -> Credits.Details {
        try await credits(forID: movie.id)
    }
}
