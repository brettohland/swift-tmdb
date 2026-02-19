internal import Dependencies
import Foundation

public extension TMDB {
    actor AuthenticationCoordinator {
        private var inProgress = false

        @Dependency(\.authSessionStore) private var sessionStore

        public init() {}

        public func createRequestToken(
            redirectTo: String = "tmdb-sdk://auth",
        ) async throws(TMDBRequestError) -> (requestToken: String, approvalURL: URL) {
            let result = try await TMDB.createRequestToken(redirectTo: redirectTo)
            let approvalURL = URL(
                string:
                "https://www.themoviedb.org/auth/access?request_token=\(result.requestToken)&redirect_to=\(redirectTo)",
            )!
            return (requestToken: result.requestToken, approvalURL: approvalURL)
        }

        public func authenticate(
            browserRedirectURL: URL,
        ) async throws(TMDBRequestError) -> AuthSession {
            guard !inProgress else { throw .authenticationAlreadyInProgress }
            inProgress = true
            defer { inProgress = false }

            // Extract the approved request token from the redirect URL
            guard
                let components = URLComponents(url: browserRedirectURL, resolvingAgainstBaseURL: false),
                let requestToken = components.queryItems?.first(where: { $0.name == "request_token" })?.value
            else {
                throw .authenticationCancelled
            }

            // Exchange request token for access token
            let accessTokenResult = try await TMDB.createAccessToken(requestToken: requestToken)

            // Convert to v3 session
            let v3SessionResult = try await TMDB.convertToV3Session(accessToken: accessTokenResult.accessToken)

            let session = AuthSession(
                accessToken: accessTokenResult.accessToken,
                accountID: accessTokenResult.accountID,
                sessionID: v3SessionResult.sessionID,
            )

            sessionStore.save(session)
            return session
        }

        public func logout() async throws(TMDBRequestError) {
            guard let session = sessionStore.load() else { return }

            // Delete v4 access token
            _ = try await TMDB.deleteAccessToken(session.accessToken)

            // Delete v3 session if present
            if let sessionID = session.sessionID {
                _ = try await TMDB.deleteV3Session(sessionID: sessionID)
            }

            sessionStore.clear()
        }
    }
}
