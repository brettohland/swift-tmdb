import Foundation

extension TMDB.Configuration.Response: MockableResponse {
    static var mockFilename: String {
        "Details"
    }
}

extension TMDB.Configuration.CountriesResponse: MockableResponse {
    static var mockFilename: String {
        "Countries"
    }
}
