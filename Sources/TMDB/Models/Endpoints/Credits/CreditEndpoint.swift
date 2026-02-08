import Foundation

extension TMDB.V3Endpoints {
    enum Credits {
        case details(id: Int)
    }
}

extension TMDB.V3Endpoints.Credits: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths = ["3"]
        switch self {
        case .details(id: let id):
            paths += ["credit", String(id)]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }

}

public extension TMDB {
    /// `/3/credit/{id}`
    ///
    /// - Parameter id: The TMDB identifier for the movie or tv show
    /// - Return: ``TMDB/Credits/Details`` value
    static func credits(forID id: Int) async throws -> Credits.Details {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Credits.Details>(
            endpoint: TMDB.V3Endpoints.Credits.details(id: id),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    /// `/3/credit/{id}`
    ///
    /// - Parameter movie: The ``TMDB/Movie`` value to use for lookup
    /// - Returns: ``TMDB/Credits/Details``
    static func credits(forMovie movie: Movie) async throws -> Credits.Details {
        try await credits(forID: movie.id)
    }
}
