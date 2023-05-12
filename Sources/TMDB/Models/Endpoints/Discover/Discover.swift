import Foundation

public extension TMDB {
    struct Discover {
        enum MediaType {
            case movie
            case tv

            var path: String {
                switch self {
                case .movie:
                    return "/discover/movie"
                case .tv:
                    return "/discover/tv"
                }
            }
        }

        let movie = Endpoint<Response<DiscoverMovie>>(path: MediaType.movie.path, method: .get)
        let tv = Endpoint<Response<DiscoverTV>>(path: MediaType.movie.path, method: .get)
    }
}
