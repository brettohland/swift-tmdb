import Foundation

public extension TMDB {
    /// Top level namespace for `Discover` values
    enum Discover {
        public typealias MovieResponse = PaginatedResponse<DiscoverMovie>
        public typealias TVResponse = PaginatedResponse<DiscoverTV>
    }
}
