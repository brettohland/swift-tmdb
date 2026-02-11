import Foundation

public extension TMDB {
    struct Review: Codable, Identifiable, Sendable, Discoverable {
        public let id: String
        public let author: String
        public let authorDetails: ReviewAuthor
        public let content: String
        public let createdAt: String
        public let updatedAt: String
        public let url: String
        public let languageCode: String?
        public let mediaID: Int?
        public let mediaTitle: String?
        public let mediaType: String?

        enum CodingKeys: String, CodingKey {
            case id
            case author
            case authorDetails
            case content
            case createdAt
            case updatedAt
            case url
            case languageCode = "iso6391"
            case mediaID = "mediaId"
            case mediaTitle
            case mediaType
        }
    }

    struct ReviewAuthor: Codable, Sendable {
        public let name: String
        public let username: String
        public let avatarPath: URL?
        public let rating: Double?
    }
}
