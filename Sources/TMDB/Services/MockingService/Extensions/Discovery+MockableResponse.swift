import Foundation

extension TMDB.Discover.DiscoverMovie: MockableResponse {
    static var mockFilename: String {
        "DiscoverMovie"
    }
}

extension TMDB.Discover.DiscoverTV: MockableResponse {
    static var mockFilename: String {
        "DiscoverTV"
    }
}
