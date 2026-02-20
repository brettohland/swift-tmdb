import Foundation

public extension TMDB.Account {
    enum MediaType: String, Codable, Sendable {
        case movie
        case tv
    }
}
