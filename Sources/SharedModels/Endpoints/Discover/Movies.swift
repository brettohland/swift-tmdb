import Foundation

public extension TMDBInternal.V3Endpoints {
    enum Movies {
        case details(id: Int)
        case alternativeTitles(id: Int)
    }
}
