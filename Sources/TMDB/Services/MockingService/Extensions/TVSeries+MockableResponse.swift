import Foundation

extension TMDB.TVSeries: MockableResponse {
    static var mockFilename: String {
        "TVSeriesDetails"
    }
}

extension TMDB.AggregateCredits: MockableResponse {
    static var mockFilename: String {
        "TVSeriesAggregateCredits"
    }
}
