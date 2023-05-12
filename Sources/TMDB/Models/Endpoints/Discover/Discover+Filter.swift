import Foundation

public extension TMDB.Discover {
    enum Value {
        case greaterThan
        case lessThan
    }

    enum Filter {
        case language(Locale)
        case sortBy(SortOption)
        case page(Int)
        case voteCountGreaterThan(Int)
        case voteAverageGreaterThan(Double)
        case withGenres([String])
        case withoutGenres([String])
        case withOriginalLanguage(Locale)
        case withoutKeywords([String])
        case withCompanies([String])
        case withKeywords([String])
        case withWatchProviders(TMDB.ParameterList)
        case watchRegion([Locale.Region])
        case withWatchMonetizationTypes([String])
        case withoutCompanies(TMDB.ParameterList)
    }

    enum MovieFilter {
        case region(Locale)
        case voteCountLessThan(Int)
        case voteAverageLessThan(Double)
        case certificationCountry(String)
        case certification(String)
        case certificationLessThan(String)
        case certificationGreaterThan(String)
        case includeAdult(Bool)
        case includeVideo(Bool)
        case primaryReleaseYear(Int)
        case primaryReleaseDateGreaterThan(Date)
        case primaryReleaseDateLessThan(Date)
        case releaseDateGreaterThan(Date)
        case releaseDateLessThan(Date)
        case withReleaseType(TMDB.ParameterList)
        case year(Int)
        case withCast([String])
        case withCrew([String])
        case withPeople([String])
        case withRuntimeGreaterThan(Int)
        case withRuntimeLessThan(Int)
    }

    enum TVFilter {
        case airDateGreaterThan(Date)
        case airDateLessThan(Date)
        case firstAirDateGreaterThan(Date)
        case firstAirDateLessThan(Date)
        case firstAirDateYear(Int)
        case timezone(TimeZone)
        case withNetworks([String])
        case withRuntimeGreaterThan(Int)
        case withRuntimeLessThan(Int)
        case includeNullFirstRunDates(Bool)
        case screenedTheatrically(Bool)
        case withStatus(String)
        case withType(String)
    }
}

extension TMDB.Discover.Filter: TMDBDiscoverFilter {
    public var key: String {
        switch self {
        case .language:
            return "language"
        case .sortBy:
            return "sort_option"
        case .page:
            return "page"
        case .voteCountGreaterThan:
            return "vote_count.gte"
        case .voteAverageGreaterThan:
            return "vote_average.gte"
        case .withGenres:
            return "with_genres"
        case .withoutGenres:
            return "without_genres"
        case .withOriginalLanguage:
            return "with_original_language"
        case .withoutKeywords:
            return "without_keywords"
        case .withCompanies:
            return "with_companies"
        case .withKeywords:
            return "with_keywords"
        case .withWatchProviders:
            return "with_watch_providers"
        case .watchRegion:
            return "watch_region"
        case .withWatchMonetizationTypes:
            return "with_watch_monetization_types"
        case .withoutCompanies:
            return "without_companies"
        }
    }

    public var value: String {
        switch self {
        case .language(let locale):
            return locale.queryValue
        case .sortBy(let option):
            return option.queryValue
        case .page(let page):
            return page.queryValue
        case .voteCountGreaterThan(let count):
            return count.queryValue
        case .voteAverageGreaterThan(let average):
            return average.queryValue
        case .withGenres(let genres):
            return genres.queryValue
        case .withOriginalLanguage(let language):
            return language.queryValue
        case .withoutKeywords(let keywords):
            return keywords.queryValue
        case .withCompanies(let companies):
            return companies.queryValue
        case .withKeywords(let keywords):
            return keywords.queryValue
        case .withWatchProviders(let providers):
            return providers.queryValue
        case .watchRegion(let regions):
            return regions.map(\.queryValue).queryValue
        case .withWatchMonetizationTypes(let types):
            return types.queryValue
        case .withoutCompanies(let companies):
            return companies.queryValue
        case .withoutGenres(let genres):
            return genres.queryValue
        }
    }
}

extension TMDB.Discover.MovieFilter: TMDBDiscoverMovieFilter {
    public var key: String {
        switch self {
        case .region:
            return "region"
        case .voteCountLessThan:
            return "vote_count.lte"
        case .voteAverageLessThan:
            return "vote_average.lte"
        case .certificationCountry:
            return "certification_country"
        case .certification:
            return "certification"
        case .certificationLessThan:
            return "certification.lte"
        case .certificationGreaterThan:
            return "certification.gte"
        case .includeAdult:
            return "include_adult"
        case .includeVideo:
            return "include_video"
        case .primaryReleaseYear:
            return "primary_release_year"
        case .primaryReleaseDateGreaterThan:
            return "primary_release_date.gte"
        case .primaryReleaseDateLessThan:
            return "primary_release_date.lte"
        case .releaseDateGreaterThan:
            return "release_date.gte"
        case .releaseDateLessThan:
            return "release_date.lte"
        case .withReleaseType:
            return "with_release_type"
        case .year:
            return "year"
        case .withCast:
            return "with_cast"
        case .withCrew:
            return "with_crew"
        case .withPeople:
            return "with_people"
        case .withRuntimeGreaterThan:
            return "with_runtime.gte"
        case .withRuntimeLessThan:
            return "with_runtime.lte"
        }
    }

    public var value: String {
        switch self {
        case .region(let value):
            return value.queryValue
        case .voteCountLessThan(let value):
            return value.queryValue
        case .voteAverageLessThan(let value):
            return value.queryValue
        case .certificationCountry(let value):
            return value.queryValue
        case .certification(let value):
            return value.queryValue
        case .certificationLessThan(let value):
            return value.queryValue
        case .certificationGreaterThan(let value):
            return value.queryValue
        case .includeAdult(let value):
            return value.queryValue
        case .includeVideo(let value):
            return value.queryValue
        case .primaryReleaseYear(let value):
            return value.queryValue
        case .primaryReleaseDateGreaterThan(let value):
            return value.queryValue
        case .primaryReleaseDateLessThan(let value):
            return value.queryValue
        case .releaseDateGreaterThan(let value):
            return value.queryValue
        case .releaseDateLessThan(let value):
            return value.queryValue
        case .withReleaseType(let value):
            return value.queryValue
        case .year(let value):
            return value.queryValue
        case .withCast(let value):
            return value.queryValue
        case .withCrew(let value):
            return value.queryValue
        case .withPeople(let value):
            return value.queryValue
        case .withRuntimeGreaterThan(let value):
            return value.queryValue
        case .withRuntimeLessThan(let value):
            return value.queryValue
        }
    }
}

extension TMDB.Discover.TVFilter: TMDBDiscoverTVFilter {
    public var key: String {
        switch self {
        case .airDateGreaterThan:
            return "air_date.gte"
        case .airDateLessThan:
            return "air_date.lte"
        case .firstAirDateGreaterThan:
            return "first_air_date.gte"
        case .firstAirDateLessThan:
            return "first_air_date.lte"
        case .firstAirDateYear:
            return "first_air_year"
        case .timezone:
            return "timezone"
        case .withNetworks:
            return "with_networks"
        case .withRuntimeGreaterThan:
            return "with_runtime.gte"
        case .withRuntimeLessThan:
            return "with_runtime.lte"
        case .includeNullFirstRunDates:
            return "include_null_first_run_dates"
        case .screenedTheatrically:
            return "screened_theatrically"
        case .withStatus:
            return "with_status"
        case .withType:
            return "with_type"
        }
    }

    public var value: String {
        switch self {
        case .airDateGreaterThan(let value):
            return value.queryValue
        case .airDateLessThan(let value):
            return value.queryValue
        case .firstAirDateGreaterThan(let value):
            return value.queryValue
        case .firstAirDateLessThan(let value):
            return value.queryValue
        case .firstAirDateYear(let value):
            return value.queryValue
        case .timezone(let value):
            return value.queryValue
        case .withNetworks(let value):
            return value.queryValue
        case .withRuntimeGreaterThan(let value):
            return value.queryValue
        case .withRuntimeLessThan(let value):
            return value.queryValue
        case .includeNullFirstRunDates(let value):
            return value.queryValue
        case .screenedTheatrically(let value):
            return value.queryValue
        case .withStatus(let value):
            return value.queryValue
        case .withType(let value):
            return value.queryValue
        }
    }
}
