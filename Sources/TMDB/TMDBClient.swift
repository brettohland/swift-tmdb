import Dependencies
import Foundation
import RequestService
import SharedModels

public extension TMDB {
    enum Client {
        enum Constants {
            static let baseURL = URL(string: "https://api.themoviedb.org")!
        }

        @MainActor private static var apiKey: String?
        @MainActor private static var isInitialized = false

        static func initialize(configuration: Configuration) async throws {
            try await checkIsInitialized()
            Task { @MainActor in
                apiKey = configuration.apiKey
                isInitialized = true
            }
        }

        static func initialize(apiKey: String) async throws {
            let configuration = Configuration(apiKey: apiKey)
            try await initialize(configuration: configuration)
        }

        @MainActor
        static func checkForAPIKey() async throws {
            guard
                let apiKey,
                apiKey.isEmpty == false
            else {
                throw TMDBError.apiKeyMissing
            }
        }

        @MainActor
        static func checkIsInitialized() async throws {
            guard isInitialized else {
                throw TMDBError.alreadyInitialized
            }
        }

    }
}

enum TMDBError: Error {
    case alreadyInitialized
    case apiKeyMissing
}

extension TMDB.Client {
    struct Configuration: Sendable {
        let apiKey: String
    }
}
