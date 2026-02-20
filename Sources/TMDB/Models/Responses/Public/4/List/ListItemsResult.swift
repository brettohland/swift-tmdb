import Foundation

public extension TMDB.List {
    /// The result of adding, updating, or removing items from a list
    struct ItemsResult: Codable, Sendable {
        public let statusCode: Int
        public let statusMessage: String
        @NilBoolean
        public var isSuccess: Bool
        public let results: [ItemResult]

        public init(statusCode: Int, statusMessage: String, isSuccess: Bool, results: [ItemResult]) {
            self.statusCode = statusCode
            self.statusMessage = statusMessage
            _isSuccess = NilBoolean(wrappedValue: isSuccess)
            self.results = results
        }

        enum CodingKeys: String, CodingKey {
            case statusCode
            case statusMessage
            case isSuccess = "success"
            case results
        }
    }

    /// The result of an individual item operation within a bulk list update
    struct ItemResult: Codable, Sendable {
        public let mediaType: String
        public let mediaID: Int
        @NilBoolean
        public var isSuccess: Bool

        public init(mediaType: String, mediaID: Int, isSuccess: Bool) {
            self.mediaType = mediaType
            self.mediaID = mediaID
            _isSuccess = NilBoolean(wrappedValue: isSuccess)
        }

        enum CodingKeys: String, CodingKey {
            case mediaType
            case mediaID = "mediaId"
            case isSuccess = "success"
        }
    }
}
