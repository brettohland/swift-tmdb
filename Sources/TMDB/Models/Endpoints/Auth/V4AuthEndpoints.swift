import Foundation

extension TMDB.V4Endpoints {
    enum Auth {
        case createRequestToken
        case createAccessToken(requestToken: String)
        case deleteAccessToken(accessToken: String)
    }
}

extension TMDB.V4Endpoints.Auth: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["4", "auth"]
        switch self {
        case .createRequestToken:
            paths.append("request_token")
        case .createAccessToken:
            paths.append("access_token")
        case .deleteAccessToken:
            paths.append("access_token")
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB {
    /// `POST /4/auth/request_token`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/auth-create-request-token)
    /// - Parameter redirectTo: The URL to redirect to after the user approves the request token
    /// - Returns: ``TMDB/Auth/RequestToken``
    /// - Throws: ``TMDBRequestError``
    static func createRequestToken(redirectTo: String = "tmdb-sdk://auth") async throws(TMDBRequestError) -> Auth
    .RequestToken {
        let endpoint = Endpoint<RequestTokenBody, Auth.RequestToken>(
            endpoint: V4Endpoints.Auth.createRequestToken,
            httpMethod: .post,
            requestBody: RequestTokenBody(redirectTo: redirectTo),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `POST /4/auth/access_token`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/auth-create-access-token)
    /// - Parameter requestToken: The approved request token
    /// - Returns: ``TMDB/Auth/AccessToken``
    /// - Throws: ``TMDBRequestError``
    static func createAccessToken(requestToken: String) async throws(TMDBRequestError) -> Auth.AccessToken {
        let endpoint = Endpoint<AccessTokenBody, Auth.AccessToken>(
            endpoint: V4Endpoints.Auth.createAccessToken(requestToken: requestToken),
            httpMethod: .post,
            requestBody: AccessTokenBody(requestToken: requestToken),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `DELETE /4/auth/access_token`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/auth-delete-access-token)
    /// - Parameter accessToken: The access token to delete
    /// - Returns: ``TMDB/Auth/DeleteResult``
    /// - Throws: ``TMDBRequestError``
    static func deleteAccessToken(_ accessToken: String) async throws(TMDBRequestError) -> Auth.DeleteResult {
        let endpoint = Endpoint<DeleteAccessTokenBody, Auth.DeleteResult>(
            endpoint: V4Endpoints.Auth.deleteAccessToken(accessToken: accessToken),
            httpMethod: .delete,
            requestBody: DeleteAccessTokenBody(accessToken: accessToken),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
