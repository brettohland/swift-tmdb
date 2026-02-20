import Foundation

struct ListItemsBody: Encodable {
    let items: [ListItemEntry]
}

struct ListItemEntry: Encodable {
    let mediaType: String
    let mediaID: Int
    let comment: String?

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case comment
    }
}
