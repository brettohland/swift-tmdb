@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct AuthClient: Sendable {
    /// Create a new v4 request token
    public var createRequestToken: @Sendable (_ redirectTo: String) async throws -> TMDB.Auth.RequestToken
    /// Exchange an approved request token for an access token
    public var createAccessToken: @Sendable (_ requestToken: String) async throws -> TMDB.Auth.AccessToken
    /// Delete a v4 access token
    public var deleteAccessToken: @Sendable (_ accessToken: String) async throws -> TMDB.Auth.DeleteResult
    /// Convert a v4 access token to a v3 session
    public var convertToV3Session: @Sendable (_ accessToken: String) async throws -> TMDB.Auth.V3Session
    /// Delete a v3 session
    public var deleteV3Session: @Sendable (_ sessionID: String) async throws -> TMDB.Auth.DeleteResult
}

public extension DependencyValues {
    /// Dependency that represents the TMDB auth endpoints
    var tmdbAuth: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

extension AuthClient: DependencyKey {
    public static var liveValue: AuthClient {
        Self(
            createRequestToken: {
                try await TMDB.createRequestToken(redirectTo: $0)
            },
            createAccessToken: {
                try await TMDB.createAccessToken(requestToken: $0)
            },
            deleteAccessToken: {
                try await TMDB.deleteAccessToken($0)
            },
            convertToV3Session: {
                try await TMDB.convertToV3Session(accessToken: $0)
            },
            deleteV3Session: {
                try await TMDB.deleteV3Session(sessionID: $0)
            },
        )
    }
}
