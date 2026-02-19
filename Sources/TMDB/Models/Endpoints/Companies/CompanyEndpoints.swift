import Foundation

extension TMDB.V3Endpoints {
    enum Companies {
        case details(id: Int)
        case images(id: Int)
    }
}

extension TMDB.V3Endpoints.Companies: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "company"]
        switch self {
        case .details(let id):
            // /3/company/{id}
            paths.append(String(id))
        case .images(let id):
            // /3/company/{id}/images
            paths += [String(id), "images"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: - Public /3/company/ endpoints

// MARK: Company Details

public extension TMDB {
    /// `/3/company/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/company-details)
    /// - Parameter id: `Int` TMDB's unique identifier for the company
    /// - Returns: ``TMDB/Company``
    /// - Throws: ``TMDBRequestError``
    static func companyDetails(id: Int) async throws(TMDBRequestError) -> Company {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Company>(
            endpoint: V3Endpoints.Companies.details(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Company Images

public extension TMDB {
    /// `/3/company/{id}/images`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/company-images)
    /// - Parameter id: `Int` TMDB's unique identifier for the company
    /// - Returns: ``TMDB/LogoCollection``
    /// - Throws: ``TMDBRequestError``
    static func companyImages(id: Int) async throws(TMDBRequestError) -> LogoCollection {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.LogoCollection>(
            endpoint: V3Endpoints.Companies.images(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
