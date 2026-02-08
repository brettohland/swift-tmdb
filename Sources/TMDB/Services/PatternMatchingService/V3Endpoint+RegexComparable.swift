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
        case .credits:
            "^/3/movie/\\d+/credits$"
        case .images:
            "^/3/movie/\\d+/images$"
        case .videos:
            "^/3/movie/\\d+/videos$"
        case .reviews:
            "^/3/movie/\\d+/reviews$"
        case .keywords:
            "^/3/movie/\\d+/keywords$"
        case .similar:
            "^/3/movie/\\d+/similar$"
        case .recommendations:
            "^/3/movie/\\d+/recommendations$"
        case .releaseDates:
            "^/3/movie/\\d+/release_dates$"
        case .externalIDs:
            "^/3/movie/\\d+/external_ids$"
        case .translations:
            "^/3/movie/\\d+/translations$"
        case .watchProviders:
            "^/3/movie/\\d+/watch/providers$"
        case .changes:
            "^/3/movie/\\d+/changes$"
        case .latest:
            "^/3/movie/latest$"
        case .nowPlaying:
            "^/3/movie/now_playing$"
        case .popular:
            "^/3/movie/popular$"
        case .topRated:
            "^/3/movie/top_rated$"
        case .upcoming:
            "^/3/movie/upcoming$"
        }
    }
}

extension TMDB.V3Endpoints.Reviews: RegexComparable {
    var patternString: String {
        switch self {
        case .details:
            "^/3/review/[a-zA-Z0-9]+$"
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
