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

extension TMDB.MovieCredits: MockableResponse {
    static var mockFilename: String {
        "MovieCredits"
    }
}

extension TMDB.ImageCollection: MockableResponse {
    static var mockFilename: String {
        "MovieImages"
    }
}

extension TMDB.VideoCollection: MockableResponse {
    static var mockFilename: String {
        "MovieVideos"
    }
}

extension TMDB.ExternalIDs: MockableResponse {
    static var mockFilename: String {
        "MovieExternalIDs"
    }
}

extension TMDB.MovieWatchProviderResult: MockableResponse {
    static var mockFilename: String {
        "MovieWatchProviders"
    }
}

extension TMDB.ChangeCollection: MockableResponse {
    static var mockFilename: String {
        "MovieChanges"
    }
}

extension TMDB.TranslationCollection: MockableResponse {
    static var mockFilename: String {
        "MovieTranslations"
    }
}
