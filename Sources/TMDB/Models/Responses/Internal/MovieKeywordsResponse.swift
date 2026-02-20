import Foundation

struct MovieKeywordsResponse: Codable {
    let id: Int
    let keywords: [TMDB.Keyword]
}
