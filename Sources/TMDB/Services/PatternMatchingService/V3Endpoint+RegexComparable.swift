import Foundation

extension TMDB.V3Endpoints.Configuration: RegexComparable {
    var pattern: Regex<Substring> {
        switch self {
        case .details:
            /^\/3\/configuration$/
        case .countries:
            /^\/3\/configuration\/countries$/
        }
    }
}

extension TMDB.V3Endpoints.Movies: RegexComparable {
    var pattern: Regex<Substring> {
        switch self {
        case .details:
            /^\/3\/movie\/\d+$/
        case .alternativeTitles:
            /^\/3\/movie\/\d+\/alternative_titles$/
        }
    }
}

extension TMDB.V3Endpoints.Discover: RegexComparable {
    var pattern: Regex<Substring> {
        switch self {
        case .movie:
            /^\/3\/discover\/movie$/
        case .tv:
            /^\/3\/discover\/tv$/
        }
    }
}
