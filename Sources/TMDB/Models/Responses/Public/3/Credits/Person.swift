import Foundation

public extension TMDB.Credits {
    struct Person: Codable, Identifiable, Sendable {
        public let isAdult: Bool
        public let id: Int
        public let name: String
        public let originalName: String
        public let mediaType: String
        public let popularity: Double
        public let gender: Int
        public let knownForDepartment: String
        public let profilePath: String

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case id
            case name
            case originalName
            case mediaType
            case popularity
            case gender
            case knownForDepartment
            case profilePath
        }
    }
}
