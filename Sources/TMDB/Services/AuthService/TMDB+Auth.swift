internal import Dependencies
import Foundation

public extension TMDB {
    /// Whether the user is currently authenticated
    static var isAuthenticated: Bool {
        currentSession != nil
    }

    /// The current auth session, if authenticated
    static var currentSession: AuthSession? {
        @Dependency(\.authSessionStore) var sessionStore
        return sessionStore.load()
    }

    /// Logs out the current user by deleting the v4 access token, v3 session, and clearing the keychain
    static func logout() async throws(TMDBRequestError) {
        let coordinator = AuthenticationCoordinator()
        try await coordinator.logout()
    }
}
