internal import Dependencies
internal import DependenciesMacros
import Foundation
import Security

extension TMDB {
    @DependencyClient
    struct AuthSessionStore: Sendable {
        var load: @Sendable () -> TMDB.AuthSession?
        var save: @Sendable (TMDB.AuthSession) -> Void
        var clear: @Sendable () -> Void
    }
}

extension DependencyValues {
    var authSessionStore: TMDB.AuthSessionStore {
        get { self[TMDB.AuthSessionStore.self] }
        set { self[TMDB.AuthSessionStore.self] = newValue }
    }
}

extension TMDB.AuthSessionStore: DependencyKey {
    private static let service = "swift-tmdb"
    private static let account = "auth-session"

    static var liveValue: Self {
        TMDB.AuthSessionStore(
            load: {
                let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrService as String: service,
                    kSecAttrAccount as String: account,
                    kSecReturnData as String: true,
                    kSecMatchLimit as String: kSecMatchLimitOne,
                ]
                var result: AnyObject?
                let status = SecItemCopyMatching(query as CFDictionary, &result)
                guard status == errSecSuccess, let data = result as? Data else {
                    return nil
                }
                return try? JSONDecoder.iso8601SnakeCake.decode(TMDB.AuthSession.self, from: data)
            },
            save: { session in
                guard let data = try? JSONEncoder.iso8601SnakeCake.encode(session) else { return }
                let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrService as String: service,
                    kSecAttrAccount as String: account,
                ]
                // Delete existing item first
                SecItemDelete(query as CFDictionary)
                var attributes = query
                attributes[kSecValueData as String] = data
                attributes[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
                SecItemAdd(attributes as CFDictionary, nil)
            },
            clear: {
                let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrService as String: service,
                    kSecAttrAccount as String: account,
                ]
                SecItemDelete(query as CFDictionary)
            },
        )
    }
}

extension TMDB.AuthSessionStore: TestDependencyKey {
    static var testValue: TMDB.AuthSessionStore {
        let storage = LockIsolated<TMDB.AuthSession?>(nil)
        return TMDB.AuthSessionStore(
            load: { storage.value },
            save: { session in storage.setValue(session) },
            clear: { storage.setValue(nil) },
        )
    }

    static var previewValue: TMDB.AuthSessionStore {
        TMDB.AuthSessionStore(
            load: {
                TMDB.AuthSession(
                    accessToken: "mock_access_token",
                    accountID: "mock_account_id",
                    sessionID: "mock_session_id",
                )
            },
            save: { _ in },
            clear: {},
        )
    }
}
