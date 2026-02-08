import Foundation

struct MovieReleaseDatesResponse: Codable {
    let id: Int
    let results: [TMDB.ReleaseDateResult]
}
