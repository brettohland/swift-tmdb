import Foundation

extension TMDB.AlternativeTitle: MockableResponse {
    static var mockFilename: String {
        "AlternativeTitles"
    }
}

extension TMDB.Movie: MockableResponse {
    static var mockFilename: String {
        "MovieDetails"
    }
}
