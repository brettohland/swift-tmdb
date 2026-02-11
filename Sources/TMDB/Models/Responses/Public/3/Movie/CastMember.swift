import Foundation

public extension TMDB {
    struct CastMember: Codable, Identifiable, Sendable {
        @NilBoolean
        public var isAdult: Bool
        public let gender: Int?
        public let id: Int
        public let knownForDepartment: String?
        public let name: String
        public let originalName: String
        public let popularity: Double
        public let profilePath: URL?
        public let castID: Int
        public let character: String
        public let creditID: String
        public let order: Int

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case gender
            case id
            case knownForDepartment
            case name
            case originalName
            case popularity
            case profilePath
            case castID = "castId"
            case character
            case creditID = "creditId"
            case order
        }
    }
}
