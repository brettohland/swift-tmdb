import Foundation

public extension TMDB.List {
    /// The status of an item on a list
    struct ItemStatus: Codable, Sendable {
        public let id: String
        public let mediaType: String
        public let mediaID: Int
        @NilBoolean
        public var isSuccess: Bool
        public let statusCode: Int
        public let statusMessage: String

        public init(
            id: String,
            mediaType: String,
            mediaID: Int,
            isSuccess: Bool,
            statusCode: Int,
            statusMessage: String,
        ) {
            self.id = id
            self.mediaType = mediaType
            self.mediaID = mediaID
            _isSuccess = NilBoolean(wrappedValue: isSuccess)
            self.statusCode = statusCode
            self.statusMessage = statusMessage
        }

        enum CodingKeys: String, CodingKey {
            case id
            case mediaType
            case mediaID = "mediaId"
            case isSuccess = "success"
            case statusCode
            case statusMessage
        }
    }
}
