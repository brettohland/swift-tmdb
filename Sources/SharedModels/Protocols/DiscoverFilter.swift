import Foundation

public protocol DiscoverFilter: QueryItemEncodable {
    var key: String { get }
    var value: String { get }
}

public extension DiscoverFilter {
    var queryItem: URLQueryItem {
        URLQueryItem(name: key, value: value)
    }
}

public protocol DiscoverMovieFilter: DiscoverFilter {}

public protocol DiscoverTVFilter: DiscoverFilter {}
