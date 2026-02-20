import Foundation

struct TVSeriesTranslationsResponse: Codable {
    let id: Int
    let translations: [TMDB.Translation]
}
