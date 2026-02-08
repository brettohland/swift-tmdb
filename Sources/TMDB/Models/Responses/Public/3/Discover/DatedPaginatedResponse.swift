import Foundation

public extension TMDB.Discover {
    struct DatedPaginatedResponse<Wrapped: Discoverable>: Codable, Sendable {
        public let dates: DateRange
        @NilInteger
        public var page: Int
        @NilInteger
        public var totalResults: Int
        @NilInteger
        public var totalPages: Int
        public let results: [Wrapped]
    }

    struct DateRange: Codable, Sendable {
        @ISO8601YMD
        public var maximum: Date?
        @ISO8601YMD
        public var minimum: Date?
    }
}
