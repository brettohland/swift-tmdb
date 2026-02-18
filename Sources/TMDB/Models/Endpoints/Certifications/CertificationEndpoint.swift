import Foundation

extension TMDB.V3Endpoints {
    enum Certifications {
        case movieList
        case tvList
    }
}

extension TMDB.V3Endpoints.Certifications: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "certification"]
        switch self {
        case .movieList:
            // /3/certification/movie/list
            paths += ["movie", "list"]
        case .tvList:
            // /3/certification/tv/list
            paths += ["tv", "list"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB {
    /// `/3/certification/movie/list`
    /// [API Documentation](https://developer.themoviedb.org/reference/certification-movie-list)
    /// - Returns: Movie rating certifications by country
    static func movieCertifications() async throws(TMDBRequestError) -> TMDB.MovieCertifications {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.MovieCertifications>(
            endpoint: V3Endpoints.Certifications.movieList,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/certification/tv/list`
    /// [API Documentation](https://developer.themoviedb.org/reference/certifications-tv-list)
    /// - Returns: TV rating certifications by country
    static func tvCertifications() async throws(TMDBRequestError) -> TMDB.TVCertifications {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.TVCertifications>(
            endpoint: V3Endpoints.Certifications.tvList,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
