import Foundation

extension TMDB.FindResult: MockableResponse {
    static var mockFilename: String {
        "FindByID"
    }
}
