import Foundation

public extension TMDB {
    struct SearchPerson: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        @NilBoolean
        public var isAdult: Bool
        public let gender: Int?
        public let knownForDepartment: String?
        public let popularity: Double?
        public let profilePath: String?
        public let knownFor: [MultiSearchResult]

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case isAdult = "adult"
            case gender
            case knownForDepartment
            case popularity
            case profilePath
            case knownFor
        }
    }
}
