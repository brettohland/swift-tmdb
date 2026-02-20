import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct AuthEndpointTests {
    // MARK: - V4 Auth Endpoints

    @Test func createRequestToken() async throws {
        let result = try await TMDB.createRequestToken()
        #expect(result.success)
        #expect(!result.requestToken.isEmpty)
    }

    @Test func createAccessToken() async throws {
        let result = try await TMDB.createAccessToken(requestToken: "mock_token")
        #expect(result.success)
        #expect(!result.accessToken.isEmpty)
        #expect(!result.accountID.isEmpty)
    }

    @Test func deleteAccessToken() async throws {
        let result = try await TMDB.deleteAccessToken("mock_access_token")
        #expect(result.success)
    }

    // MARK: - V3 Auth Endpoints

    @Test func convertToV3Session() async throws {
        let result = try await TMDB.convertToV3Session(accessToken: "mock_access_token")
        #expect(result.success)
        #expect(!result.sessionID.isEmpty)
    }

    @Test func deleteV3Session() async throws {
        let result = try await TMDB.deleteV3Session(sessionID: "mock_session_id")
        #expect(result.success)
    }

    // MARK: - URL Generation

    @Test func createRequestTokenURL() {
        let endpoint = TMDB.V4Endpoints.Auth.createRequestToken
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/auth/request_token")
    }

    @Test func createAccessTokenURL() {
        let endpoint = TMDB.V4Endpoints.Auth.createAccessToken(requestToken: "token")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/auth/access_token")
    }

    @Test func deleteAccessTokenURL() {
        let endpoint = TMDB.V4Endpoints.Auth.deleteAccessToken(accessToken: "token")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/auth/access_token")
    }

    @Test func convertSessionURL() {
        let endpoint = TMDB.V3Endpoints.Auth.convertSession(accessToken: "token")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/authentication/session/convert/4")
    }

    @Test func deleteSessionURL() {
        let endpoint = TMDB.V3Endpoints.Auth.deleteSession(sessionID: "session")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/authentication/session")
    }
}
