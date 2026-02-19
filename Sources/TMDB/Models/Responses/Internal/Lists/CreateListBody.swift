import Foundation

struct CreateListBody: Encodable {
    let name: String
    let description: String
    let iso6391: String
    let iso31661: String
    let isPublic: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case isPublic = "public"
    }
}
