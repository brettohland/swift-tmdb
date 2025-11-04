import Foundation

public extension TMDBInternal.V3Endpoints {
    enum Discover {
        case movie(filters: [TMDBDiscoverMovieFilter])
        case tv(filters: [TMDBDiscoverTVFilter])
    }
}

