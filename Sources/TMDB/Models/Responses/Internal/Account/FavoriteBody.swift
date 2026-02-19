import Foundation

struct FavoriteBody: Encodable {
    let mediaType: String
    let mediaId: Int
    let favorite: Bool
}
