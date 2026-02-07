import Foundation

extension TMDB.MovieCertifications: MockableResponse {
    static var mockFilename: String {
        "MovieCertifications"
    }
}

extension TMDB.TVCertifications: MockableResponse {
    static var mockFilename: String {
        "TVCertifications"
    }
}
