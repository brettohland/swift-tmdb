import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints {
    enum Configuration {
        case details
        case countries
    }
}

extension TMDBInternal.V3Endpoints.Configuration: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        // /3
        var paths = ["3"]
        switch self {
        case .details:
            // /3/configuration
            paths.append("configuration")
        case .countries:
            // /3/configuration/countries
            paths += ["configuration", "countries"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }

}

public extension TMDB.Client {
    enum APIConfiguration {
        static func details() async throws -> TMDBInternal.Configuration.Response {
            let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Configuration.Response>(
                endpoint: TMDBInternal.V3Endpoints.Configuration.details,
                httpMethod: .get,
            )
            return try await endpoint.decodedResponse()
        }

        static func countries() async throws -> [Locale.Region] {
            let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Configuration.CountriesResponse>(
                endpoint: TMDBInternal.V3Endpoints.Configuration.countries,
                httpMethod: .get,
            )
            let response = try await endpoint.decodedResponse()
            return response.countries
        }
    }
}
