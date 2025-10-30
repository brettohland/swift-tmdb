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
            "language"
        case .sortBy:
            "sort_option"
        case .page:
            "page"
        case .voteCountGreaterThan:
            "vote_count.gte"
        case .voteAverageGreaterThan:
            "vote_average.gte"
        case .withGenres:
            "with_genres"
        case .withoutGenres:
            "without_genres"
        case .withOriginalLanguage:
            "with_original_language"
        case .withoutKeywords:
            "without_keywords"
        case .withCompanies:
            "with_companies"
        case .withKeywords:
            "with_keywords"
        case .withWatchProviders:
            "with_watch_providers"
        case .watchRegion:
            "watch_region"
        case .withWatchMonetizationTypes:
            "with_watch_monetization_types"
        case .withoutCompanies:
            "without_companies"
        }
    }

    public var value: String {
        switch self {
        case .language(let locale):
            locale.queryValue
        case .sortBy(let option):
            option.queryValue
        case .page(let page):
            page.queryValue
        case .voteCountGreaterThan(let count):
            count.queryValue
        case .voteAverageGreaterThan(let average):
            average.queryValue
        case .withGenres(let genres):
            genres.queryValue
        case .withOriginalLanguage(let language):
            language.queryValue
        case .withoutKeywords(let keywords):
            keywords.queryValue
        case .withCompanies(let companies):
            companies.queryValue
        case .withKeywords(let keywords):
            keywords.queryValue
        case .withWatchProviders(let providers):
            providers.queryValue
        case .watchRegion(let regions):
            regions.map(\.queryValue).queryValue
        case .withWatchMonetizationTypes(let types):
            types.queryValue
        case .withoutCompanies(let companies):
            companies.queryValue
        case .withoutGenres(let genres):
            genres.queryValue
        }
    }
}

extension TMDB.Discover.MovieFilter: TMDBDiscoverMovieFilter {
    public var key: String {
        switch self {
        case .region:
            "region"
        case .voteCountLessThan:
            "vote_count.lte"
        case .voteAverageLessThan:
            "vote_average.lte"
        case .certificationCountry:
            "certification_country"
        case .certification:
            "certification"
        case .certificationLessThan:
            "certification.lte"
        case .certificationGreaterThan:
            "certification.gte"
        case .includeAdult:
            "include_adult"
        case .includeVideo:
            "include_video"
        case .primaryReleaseYear:
            "primary_release_year"
        case .primaryReleaseDateGreaterThan:
            "primary_release_date.gte"
        case .primaryReleaseDateLessThan:
            "primary_release_date.lte"
        case .releaseDateGreaterThan:
            "release_date.gte"
        case .releaseDateLessThan:
            "release_date.lte"
        case .withReleaseType:
            "with_release_type"
        case .year:
            "year"
        case .withCast:
            "with_cast"
        case .withCrew:
            "with_crew"
        case .withPeople:
            "with_people"
        case .withRuntimeGreaterThan:
            "with_runtime.gte"
        case .withRuntimeLessThan:
            "with_runtime.lte"
        }
    }

    public var value: String {
        switch self {
        case .region(let value):
            value.queryValue
        case .voteCountLessThan(let value):
            value.queryValue
        case .voteAverageLessThan(let value):
            value.queryValue
        case .certificationCountry(let value):
            value.queryValue
        case .certification(let value):
            value.queryValue
        case .certificationLessThan(let value):
            value.queryValue
        case .certificationGreaterThan(let value):
            value.queryValue
        case .includeAdult(let value):
            value.queryValue
        case .includeVideo(let value):
            value.queryValue
        case .primaryReleaseYear(let value):
            value.queryValue
        case .primaryReleaseDateGreaterThan(let value):
            value.queryValue
        case .primaryReleaseDateLessThan(let value):
            value.queryValue
        case .releaseDateGreaterThan(let value):
            value.queryValue
        case .releaseDateLessThan(let value):
            value.queryValue
        case .withReleaseType(let value):
            value.queryValue
        case .year(let value):
            value.queryValue
        case .withCast(let value):
            value.queryValue
        case .withCrew(let value):
            value.queryValue
        case .withPeople(let value):
            value.queryValue
        case .withRuntimeGreaterThan(let value):
            value.queryValue
        case .withRuntimeLessThan(let value):
            value.queryValue
        }
    }
}

extension TMDB.Discover.TVFilter: TMDBDiscoverTVFilter {
    public var key: String {
        switch self {
        case .airDateGreaterThan:
            "air_date.gte"
        case .airDateLessThan:
            "air_date.lte"
        case .firstAirDateGreaterThan:
            "first_air_date.gte"
        case .firstAirDateLessThan:
            "first_air_date.lte"
        case .firstAirDateYear:
            "first_air_year"
        case .timezone:
            "timezone"
        case .withNetworks:
            "with_networks"
        case .withRuntimeGreaterThan:
            "with_runtime.gte"
        case .withRuntimeLessThan:
            "with_runtime.lte"
        case .includeNullFirstRunDates:
            "include_null_first_run_dates"
        case .screenedTheatrically:
            "screened_theatrically"
        case .withStatus:
            "with_status"
        case .withType:
            "with_type"
        }
    }

    public var value: String {
        switch self {
        case .airDateGreaterThan(let value):
            value.queryValue
        case .airDateLessThan(let value):
            value.queryValue
        case .firstAirDateGreaterThan(let value):
            value.queryValue
        case .firstAirDateLessThan(let value):
            value.queryValue
        case .firstAirDateYear(let value):
            value.queryValue
        case .timezone(let value):
            value.queryValue
        case .withNetworks(let value):
            value.queryValue
        case .withRuntimeGreaterThan(let value):
            value.queryValue
        case .withRuntimeLessThan(let value):
            value.queryValue
        case .includeNullFirstRunDates(let value):
            value.queryValue
        case .screenedTheatrically(let value):
            value.queryValue
        case .withStatus(let value):
            value.queryValue
        case .withType(let value):
            value.queryValue
        }
    }
}
