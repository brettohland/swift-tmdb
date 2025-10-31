
import Foundation

public extension TMDBInternal {

    enum ReleaseStatus: String, Codable, Sendable {
        case released = "Released"
        case postProduction = "Post Production"
    }
}
