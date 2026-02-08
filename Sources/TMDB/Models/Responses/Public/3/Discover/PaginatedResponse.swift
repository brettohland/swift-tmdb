import Foundation

public extension TMDB.Discover {
    struct PaginatedResponse<Wrapped: Discoverable>: Codable, Sendable {
        @NilInteger
        public var page: Int
        @NilInteger
        public var totalResults: Int
        @NilInteger
        public var totalPages: Int
        public let results: [Wrapped]
    }
}
