import Foundation

extension TMDB.ConfigurationResponse: MockableResponse {
    static var mockFilename: String {
        "Details"
    }
}

extension CountriesResponse: MockableResponse {
    static var mockFilename: String {
        "Countries"
    }
}
