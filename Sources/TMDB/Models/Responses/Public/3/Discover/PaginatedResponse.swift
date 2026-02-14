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

        public init(page: Int, totalResults: Int, totalPages: Int, results: [Wrapped]) {
            _page = NilInteger(wrappedValue: page)
            _totalResults = NilInteger(wrappedValue: totalResults)
            _totalPages = NilInteger(wrappedValue: totalPages)
            self.results = results
        }

        enum CodingKeys: String, CodingKey {
            case page
            case totalResults
            case totalPages
            case results
        }
    }
}
