import Foundation

extension TMDB.TrendingResult: MockableResponse {
    static var mockFilename: String {
        "TrendingAll"
    }
}

extension TMDB.TrendingPerson: MockableResponse {
    static var mockFilename: String {
        "TrendingPeople"
    }
}
