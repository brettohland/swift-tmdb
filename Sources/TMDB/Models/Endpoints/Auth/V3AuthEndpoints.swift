import Foundation

extension TMDB.V3Endpoints {
    enum Auth {
        case convertSession(accessToken: String)
        case deleteSession(sessionID: String)
    }
}

extension TMDB.V3Endpoints.Auth: EndpointFactory {
    var supportsLanguage: Bool { false }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "authentication"]
        switch self {
        case .convertSession:
            paths += ["session", "convert", "4"]
        case .deleteSession:
            paths.append("session")
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB {
    /// `POST /3/authentication/session/convert/4`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/authentication-create-session-from-v4-token)
    /// - Parameter accessToken: The v4 access token to convert
    /// - Returns: ``TMDB/Auth/V3Session``
    /// - Throws: ``TMDBRequestError``
    static func convertToV3Session(accessToken: String) async throws(TMDBRequestError) -> Auth.V3Session {
        let endpoint = Endpoint<ConvertSessionBody, Auth.V3Session>(
            endpoint: V3Endpoints.Auth.convertSession(accessToken: accessToken),
            httpMethod: .post,
            requestBody: ConvertSessionBody(accessToken: accessToken),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `DELETE /3/authentication/session`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/reference/authentication-delete-session)
    /// - Parameter sessionID: The v3 session ID to delete
    /// - Returns: ``TMDB/Auth/DeleteResult``
    /// - Throws: ``TMDBRequestError``
    static func deleteV3Session(sessionID: String) async throws(TMDBRequestError) -> Auth.DeleteResult {
        let endpoint = Endpoint<DeleteSessionBody, Auth.DeleteResult>(
            endpoint: V3Endpoints.Auth.deleteSession(sessionID: sessionID),
            httpMethod: .delete,
            requestBody: DeleteSessionBody(sessionId: sessionID),
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
