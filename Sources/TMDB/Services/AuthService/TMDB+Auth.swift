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
}
