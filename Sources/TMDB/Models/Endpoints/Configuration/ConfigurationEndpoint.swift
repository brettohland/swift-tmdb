import Foundation

extension TMDB.V3Endpoints {
    enum Configuration {
        case details
        case countries
    }
}

extension TMDB.V3Endpoints.Configuration: EndpointFactory {
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

extension TMDB {
    enum APIConfiguration {
        static func details() async throws -> TMDB.Configuration.Response {
            let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Configuration.Response>(
                endpoint: TMDB.V3Endpoints.Configuration.details,
                httpMethod: .get,
            )
            return try await endpoint.decodedResponse()
        }

        static func countries() async throws -> [Locale.Region] {
            let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Configuration.CountriesResponse>(
                endpoint: TMDB.V3Endpoints.Configuration.countries,
                httpMethod: .get,
            )
            let response = try await endpoint.decodedResponse()
            return response.countries
        }
    }
}
