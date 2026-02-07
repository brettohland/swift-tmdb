import Foundation

public extension TMDB.Configuration {
    /// Represents a job department from the `/3/configuration/jobs` endpoint
    ///
    /// [Details on TMDB's site](https://developer.themoviedb.org/reference/configuration-jobs)
    struct JobDepartment: Codable, Sendable {
        public let department: String
        public let jobs: [String]
    }
}
