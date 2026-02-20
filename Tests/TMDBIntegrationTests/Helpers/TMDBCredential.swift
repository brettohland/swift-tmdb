import Foundation

enum TMDBCredential {
    static var apiKey: String? {
        ProcessInfo.processInfo.environment["TMDB_API_KEY"]
    }

    static var isAvailable: Bool {
        guard let key = apiKey else { return false }
        return !key.isEmpty
    }
}
