import Foundation

struct TVSeriesKeywordsResponse: Codable {
    let id: Int
    let results: [TMDB.Keyword]
}
