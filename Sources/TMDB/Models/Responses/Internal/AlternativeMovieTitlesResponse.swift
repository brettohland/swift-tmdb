import Foundation

struct AlternativeMovieTitlesResponse: Equatable, Identifiable, Codable {
    let id: Int
    let titles: [TMDB.AlternativeTitle]
}
