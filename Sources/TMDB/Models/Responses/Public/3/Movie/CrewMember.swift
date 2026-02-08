import Foundation

public extension TMDB {
    struct CrewMember: Codable, Identifiable, Sendable {
        @NilBoolean
        public var isAdult: Bool
        public let gender: Int?
        public let id: Int
        public let knownForDepartment: String?
        public let name: String
        public let originalName: String
        public let popularity: Double
        public let profilePath: String?
        public let creditID: String
        public let department: String
        public let job: String

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case gender
            case id
            case knownForDepartment
            case name
            case originalName
            case popularity
            case profilePath
            case creditID = "creditId"
            case department
            case job
        }
    }
}
