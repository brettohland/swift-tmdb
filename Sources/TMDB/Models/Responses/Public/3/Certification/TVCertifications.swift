import Foundation

public extension TMDB {
    /// Represents TV certifications from the `/3/certification/tv/list` endpoint
    ///
    /// [Details on TMDB's site](https://developer.themoviedb.org/reference/certifications-tv-list)
    struct TVCertifications: Codable, Sendable {
        public let certifications: [String: [Certification]]
    }
}
