import Foundation

public extension TMDB.Credits {
    struct Person: Codable, Identifiable, Sendable {
        public let adult: Bool
        public let id: Int
        public let name: String
        public let originalName: String
        public let mediaType: String
        public let popularity: Double
        public let gender: Int
        public let knownForDepartment: String
        public let profilePath: String
    }
}
