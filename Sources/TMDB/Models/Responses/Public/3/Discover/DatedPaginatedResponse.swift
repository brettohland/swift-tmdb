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

        public init(dates: DateRange, page: Int, totalResults: Int, totalPages: Int, results: [Wrapped]) {
            self.dates = dates
            _page = NilInteger(wrappedValue: page)
            _totalResults = NilInteger(wrappedValue: totalResults)
            _totalPages = NilInteger(wrappedValue: totalPages)
            self.results = results
        }
    }

    struct DateRange: Codable, Sendable {
        @ISO8601YMD
        public var maximum: Date?
        @ISO8601YMD
        public var minimum: Date?

        public init(maximum: Date?, minimum: Date?) {
            _maximum = ISO8601YMD(wrappedValue: maximum)
            _minimum = ISO8601YMD(wrappedValue: minimum)
        }
    }
}
