import Foundation

extension TMDB.V3Endpoints.Configuration: RegexComparable {
    var patternString: String {
        switch self {
        case .details:
            "^/3/configuration$"
        case .countries:
            "^/3/configuration/countries$"
        case .jobs:
            "^/3/configuration/jobs$"
        case .languages:
            "^/3/configuration/languages$"
        case .primaryTranslations:
            "^/3/configuration/primary_translations$"
        case .timezones:
            "^/3/configuration/timezones$"
        }
    }
}

extension TMDB.V3Endpoints.Movies: RegexComparable {
    var patternString: String {
        switch self {
        case .details:
            "^/3/movie/\\d+$"
        case .alternativeTitles:
            "^/3/movie/\\d+/alternative_titles$"
        }
    }
}

extension TMDB.V3Endpoints.Discover: RegexComparable {
    var patternString: String {
        switch self {
        case .movie:
            "^/3/discover/movie$"
        case .tv:
            "^/3/discover/tv$"
        }
    }
}

extension TMDB.V3Endpoints.Certifications: RegexComparable {
    var patternString: String {
        switch self {
        case .movieList:
            "^/3/certification/movie/list$"
        case .tvList:
            "^/3/certification/tv/list$"
        }
    }
}

extension TMDB.V3Endpoints.Genres: RegexComparable {
    var patternString: String {
        switch self {
        case .movieList:
            "^/3/genre/movie/list$"
        case .tvList:
            "^/3/genre/tv/list$"
        }
    }
}

extension TMDB.V3Endpoints.Trending: RegexComparable {
    var patternString: String {
        switch self {
        case .all:
            "^/3/trending/all/(?:day|week)$"
        case .movie:
            "^/3/trending/movie/(?:day|week)$"
        case .tv:
            "^/3/trending/tv/(?:day|week)$"
        case .person:
            "^/3/trending/person/(?:day|week)$"
        }
    }
}

extension TMDB.V3Endpoints.WatchProviders: RegexComparable {
    var patternString: String {
        switch self {
        case .regions:
            "^/3/watch/providers/regions$"
        case .movie:
            "^/3/watch/providers/movie$"
        case .tv:
            "^/3/watch/providers/tv$"
        }
    }
}
