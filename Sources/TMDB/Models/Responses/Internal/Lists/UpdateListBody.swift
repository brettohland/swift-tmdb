import Foundation

struct UpdateListBody: Encodable {
    let name: String?
    let description: String?
    let isPublic: Bool?
    let sortBy: String?

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case isPublic = "public"
        case sortBy = "sort_by"
    }
}
