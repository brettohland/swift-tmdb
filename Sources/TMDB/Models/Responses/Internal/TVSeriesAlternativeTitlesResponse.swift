import Foundation

struct TVSeriesAlternativeTitlesResponse: Codable {
    let id: Int
    let results: [TMDB.AlternativeTitle]
}
