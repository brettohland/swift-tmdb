import Foundation

public extension TMDB {
    enum ReleaseStatus: String, Codable, Sendable {
        case released = "Released"
        case postProduction = "Post Production"
    }
}
