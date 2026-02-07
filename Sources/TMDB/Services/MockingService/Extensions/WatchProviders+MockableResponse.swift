import Foundation

extension TMDB.WatchProviderRegions: MockableResponse {
    static var mockFilename: String {
        "Regions"
    }
}

extension TMDB.WatchProviderList: MockableResponse {
    static var mockFilename: String {
        "MovieProviders"
    }
}
