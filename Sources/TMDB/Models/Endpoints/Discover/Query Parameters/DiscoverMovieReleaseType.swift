import Foundation

public extension TMDB.Discover {
    enum MediaReleaseType: Int, CustomStringConvertible {
        /// Premier (Query Parameter Value: `1`)
        case premier = 1
        /// Theatrical (Limited) (Query Parameter Value: `2`)
        case limitedTheatrical
        /// Theatrical (Query Parameter Value: `3`)
        case theatrical
        /// Digital (Query Parameter Value: `4`)
        case digital
        /// Physical (Query Parameter Value: `5`)
        case physical
        /// TV (Query Parameter Value: `6`)
        case tv

        public var description: String {
            String(rawValue)
        }
    }
}
