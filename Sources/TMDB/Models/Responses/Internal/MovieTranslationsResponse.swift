import Foundation

struct MovieTranslationsResponse: Codable {
    let id: Int
    let translations: [TMDB.Translation]
}
