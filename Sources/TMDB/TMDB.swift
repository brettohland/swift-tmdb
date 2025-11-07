import Foundation

@MainActor
public final class TMDB {
    private static var apiKey: String?
    private static var isInitialized = false

    public static func initialize(configuration: TMDBConfiguration) throws {
        guard isInitialized == false else {
            throw TMDBInitializationError.alreadyInitialized
        }
        apiKey = configuration.apiKey
        isInitialized = true
    }

    public static func initialize(apiKey: String) throws {
        let configuration = TMDBConfiguration(apiKey: apiKey)
        try initialize(configuration: configuration)
    }

    public static func checkForAPIKey() throws {
        guard
            let apiKey,
            apiKey.isEmpty == false
        else {
            throw TMDBInitializationError.apiKeyMissing
        }
    }

    public static func checkIsInitialized() throws {
        guard isInitialized else {
            throw TMDBInitializationError.alreadyInitialized
        }
    }
}

