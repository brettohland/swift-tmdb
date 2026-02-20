import Foundation

public extension TMDB {
    /// Represents movie certifications from the `/3/certification/movie/list` endpoint
    ///
    /// [Details on TMDB's site](https://developer.themoviedb.org/reference/certification-movie-list)
    struct MovieCertifications: Codable, Sendable {
        public let certifications: [String: [Certification]]

        public init(certifications: [String: [Certification]]) {
            self.certifications = certifications
        }
    }
}
