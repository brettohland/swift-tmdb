import Foundation

public extension TMDB.Credits {
    struct Details: Codable, Identifiable, Sendable {
        public let type: String
        public let department: String
        public let job: String
        public let media: Media
        public let mediaType: String
        public let id: String
        public let person: Person

        public init(
            type: String,
            department: String,
            job: String,
            media: Media,
            mediaType: String,
            id: String,
            person: Person,
        ) {
            self.type = type
            self.department = department
            self.job = job
            self.media = media
            self.mediaType = mediaType
            self.id = id
            self.person = person
        }

        enum CodingKeys: String, CodingKey {
            case type = "creditType"
            case department
            case job
            case media
            case mediaType
            case id
            case person
        }
    }
}
