import Foundation

extension TMDB.V3Endpoints {
    enum Credits {
        case details(id: String)
    }
}

extension TMDB.V3Endpoints.Credits: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths = ["3"]
        switch self {
        case .details(id: let id):
            paths += ["credit", id]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB {
    /// `/3/credit/{id}`
    ///
    /// - Parameter id: The credit identifier (e.g. "52fe4250c3a36847f80149f3")
    /// - Return: ``TMDB/Credits/Details`` value
    static func credits(forID id: String) async throws(TMDBRequestError) -> Credits.Details {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Credits.Details>(
            endpoint: TMDB.V3Endpoints.Credits.details(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
