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
        public let profilePath: URL?
        public let creditID: String
        public let department: String
        public let job: String

        public init(
            isAdult: Bool,
            gender: Int?,
            id: Int,
            knownForDepartment: String?,
            name: String,
            originalName: String,
            popularity: Double,
            profilePath: URL?,
            creditID: String,
            department: String,
            job: String,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.gender = gender
            self.id = id
            self.knownForDepartment = knownForDepartment
            self.name = name
            self.originalName = originalName
            self.popularity = popularity
            self.profilePath = profilePath
            self.creditID = creditID
            self.department = department
            self.job = job
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
            case creditID = "creditId"
            case department
            case job
        }
    }
}
