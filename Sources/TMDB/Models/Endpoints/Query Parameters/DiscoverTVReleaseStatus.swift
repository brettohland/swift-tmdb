import Foundation

extension TMDB.Discover {
    enum TVReleaseStatus: Int, CustomStringConvertible {
        /// Returning Series (Query Parameter Value: `0`)
        case returningSeries = 0
        /// Planned (Query Parameter Value: `1`)
        case planned
        /// In Production (Query Parameter Value: `2`)
        case inProduction
        /// Ended (Query Parameter Value: `3`)
        case ended
        /// Canceled (Query Parameter Value: `4`)
        case canceled
        /// Pilot (Query Parameter Value: `5`)
        case pilot

        var description: String {
            String(rawValue)
        }
    }
}
