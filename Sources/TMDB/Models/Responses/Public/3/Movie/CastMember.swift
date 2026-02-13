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
        public let castID: Int?
        public let character: String
        public let creditID: String
        public let order: Int

        public init(
            isAdult: Bool,
            gender: Int?,
            id: Int,
            knownForDepartment: String?,
            name: String,
            originalName: String,
            popularity: Double,
            profilePath: URL?,
            castID: Int?,
            character: String,
            creditID: String,
            order: Int,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.gender = gender
            self.id = id
            self.knownForDepartment = knownForDepartment
            self.name = name
            self.originalName = originalName
            self.popularity = popularity
            self.profilePath = profilePath
            self.castID = castID
            self.character = character
            self.creditID = creditID
            self.order = order
        }

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
