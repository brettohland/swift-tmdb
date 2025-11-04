import Foundation
import SharedModels

extension TMDBInternal.Configuration.Response: MockableResponse {
    public static var mockFilename: String {
        "Details"
    }
}

extension TMDBInternal.Configuration.CountriesResponse: MockableResponse {
    public static var mockFilename: String {
        "Countries"
    }
}
