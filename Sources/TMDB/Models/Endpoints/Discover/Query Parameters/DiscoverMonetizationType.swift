import Foundation

public extension TMDB.Discover {
    enum MonetizationType: String, CustomStringConvertible {
        case flatRate = "flatrate"
        case free
        case ads
        case rent
        case buy

        public var description: String {
            rawValue
        }
    }

}
