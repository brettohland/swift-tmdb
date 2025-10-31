import Foundation

public protocol TMDBDiscoverFilter: QueryItemEncodable {
    var key: String { get }
    var value: String { get }
}

public extension TMDBDiscoverFilter {
    var queryItem: URLQueryItem {
        URLQueryItem(name: key, value: value)
    }
}

public protocol TMDBDiscoverMovieFilter: TMDBDiscoverFilter {}

public protocol TMDBDiscoverTVFilter: TMDBDiscoverFilter {}
