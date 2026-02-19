import Foundation

struct WatchlistBody: Encodable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
}
