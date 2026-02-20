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

        public init(
            id: String,
            author: String,
            authorDetails: ReviewAuthor,
            content: String,
            createdAt: String,
            updatedAt: String,
            url: String,
            languageCode: String?,
            mediaID: Int?,
            mediaTitle: String?,
            mediaType: String?,
        ) {
            self.id = id
            self.author = author
            self.authorDetails = authorDetails
            self.content = content
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.url = url
            self.languageCode = languageCode
            self.mediaID = mediaID
            self.mediaTitle = mediaTitle
            self.mediaType = mediaType
        }

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

        public init(name: String, username: String, avatarPath: URL?, rating: Double?) {
            self.name = name
            self.username = username
            self.avatarPath = avatarPath
            self.rating = rating
        }
    }
}
