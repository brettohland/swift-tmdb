import Foundation

extension TMDB.Discover {
    enum MonetizationType: String, CustomStringConvertible {
        case flatRate = "flatrate"
        case free
        case ads
        case rent
        case buy

        var description: String {
            rawValue
        }
    }

}
