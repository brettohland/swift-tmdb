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

public extension TMDB {
    /// `/3/configuration/details`
    /// - Returns: The configuration response from the backend
    static func apiConfigurationDetails() async throws -> TMDB.ConfigurationResponse {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ConfigurationResponse>(
            endpoint: TMDB.V3Endpoints.Configuration.details,
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    /// `/3/configuration/countries`
    /// - Returns: An array of countries supported by the API
    static func supportedCountries() async throws -> [Locale.Region] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, CountriesResponse>(
            endpoint: TMDB.V3Endpoints.Configuration.countries,
            httpMethod: .get,
        )
        let response = try await endpoint.decodedResponse()
        return response.countries
    }
}
