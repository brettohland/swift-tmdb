import Foundation
import SharedModels

extension TMDBInternal.Movie.AlternativeTitle: MockableResponse {
    public static var mockFilename: String {
        "AlternativeTitles"
    }
}

extension TMDBInternal.Movie.Details: MockableResponse {
    public static var mockFilename: String {
        "MovieDetails"
    }
}
