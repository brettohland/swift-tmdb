import Foundation
import SharedModels

extension TMDBInternal.Discover.DiscoverMovie: MockableResponse {
    public static var mockFilename: String {
        "DiscoverMovie"
    }
}

extension TMDBInternal.Discover.DiscoverTV: MockableResponse {
    public static var mockFilename: String {
        "DiscoverTV"
    }
}
