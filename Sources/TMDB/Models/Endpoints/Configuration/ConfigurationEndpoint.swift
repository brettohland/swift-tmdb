import Foundation

extension TMDB.V3Endpoints {
    enum Configuration {
        case details
        case countries
        case jobs
        case languages
        case primaryTranslations
        case timezones
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
        case .jobs:
            // /3/configuration/jobs
            paths += ["configuration", "jobs"]
        case .languages:
            // /3/configuration/languages
            paths += ["configuration", "languages"]
        case .primaryTranslations:
            // /3/configuration/primary_translations
            paths += ["configuration", "primary_translations"]
        case .timezones:
            // /3/configuration/timezones
            paths += ["configuration", "timezones"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }

}

public extension TMDB {
    /// `/3/configuration`
    /// - Returns: The configuration response from the backend
    static func configurationDetails() async throws(TMDBRequestError) -> TMDB.ConfigurationResponse {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.ConfigurationResponse>(
            endpoint: TMDB.V3Endpoints.Configuration.details,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/configuration/countries`
    /// - Returns: An array of countries supported by the API
    static func supportedCountries() async throws(TMDBRequestError) -> [Locale.Region] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, CountriesResponse>(
            endpoint: TMDB.V3Endpoints.Configuration.countries,
            httpMethod: .get,
        )
        do {
            let response = try await endpoint.decodedResponse()
            return response.countries
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/configuration/jobs`
    /// [API Documentation](https://developer.themoviedb.org/reference/configuration-jobs)
    /// - Returns: An array of job departments and their available jobs
    static func jobDepartments() async throws(TMDBRequestError) -> [TMDB.Configuration.JobDepartment] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, [TMDB.Configuration.JobDepartment]>(
            endpoint: TMDB.V3Endpoints.Configuration.jobs,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/configuration/languages`
    /// [API Documentation](https://developer.themoviedb.org/reference/configuration-languages)
    /// - Returns: An array of supported languages
    static func supportedLanguages() async throws(TMDBRequestError) -> [TMDB.Configuration.Language] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, [TMDB.Configuration.Language]>(
            endpoint: TMDB.V3Endpoints.Configuration.languages,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/configuration/primary_translations`
    /// [API Documentation](https://developer.themoviedb.org/reference/configuration-primary-translations)
    /// - Returns: An array of primary translation language codes
    static func primaryTranslations() async throws(TMDBRequestError) -> [String] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, [String]>(
            endpoint: TMDB.V3Endpoints.Configuration.primaryTranslations,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/configuration/timezones`
    /// [API Documentation](https://developer.themoviedb.org/reference/configuration-timezones)
    /// - Returns: An array of timezone groups by country
    static func timezones() async throws(TMDBRequestError) -> [TMDB.Configuration.Timezone] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, [TMDB.Configuration.Timezone]>(
            endpoint: TMDB.V3Endpoints.Configuration.timezones,
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
