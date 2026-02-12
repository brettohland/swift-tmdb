import Foundation
import TMDB

extension TMDB.TVSeries: MockableResponse {
    static var mockFilename: String { "TVSeriesDetails" }
}

public extension TMDB.TVSeries {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}

extension TMDB.AggregateCredits: MockableResponse {
    static var mockFilename: String { "TVSeriesAggregateCredits" }
}

public extension TMDB.AggregateCredits {
    static func mock() throws -> Self { try _loadMock() }
    static func mockData() throws -> Data { try _loadMockData() }
}
