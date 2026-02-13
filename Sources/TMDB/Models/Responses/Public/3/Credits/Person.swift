import Foundation

public extension TMDB.Credits {
    struct Person: Codable, Identifiable, Sendable {
        @NilBoolean public var isAdult: Bool
        public let id: Int
        public let name: String
        public let originalName: String
        public let mediaType: String
        public let popularity: Double
        public let gender: Int
        public let knownForDepartment: String
        public let profilePath: URL

        public init(
            isAdult: Bool,
            id: Int,
            name: String,
            originalName: String,
            mediaType: String,
            popularity: Double,
            gender: Int,
            knownForDepartment: String,
            profilePath: URL,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.id = id
            self.name = name
            self.originalName = originalName
            self.mediaType = mediaType
            self.popularity = popularity
            self.gender = gender
            self.knownForDepartment = knownForDepartment
            self.profilePath = profilePath
        }

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
