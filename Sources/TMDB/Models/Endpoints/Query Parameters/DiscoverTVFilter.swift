import Foundation

extension TMDB.Discover {
    enum TVFilter {

        // Common filters
        case language(Locale)
        case page(Int)
        case sortBy(SortOption)
        case voteAverageGreaterThan(Double)
        case voteCountGreaterThan(Int)
        case watchRegion(Locale.Region)
        case withCompanies([LogicalOperator<String>])
        case withGenres([LogicalOperator<String>])
        case withKeywords([LogicalOperator<String>])
        case withOriginCountry(Locale.Region)
        case withOriginalLanguage(Locale.Language)
        case withWatchMonetizationTypes([LogicalOperator<MonetizationType>])
        case withWatchProviders([LogicalOperator<String>])
        case withoutGenres([LogicalOperator<String>])
        case withoutKeywords([String])
        case withoutCompanies([String])

        // TV Filters
        case airDateGreaterThan(Date)
        case airDateLessThan(Date)
        case firstAirDateGreaterThan(Date)
        case firstAirDateLessThan(Date)
        case firstAirDateYear(Int)
        case timezone(TimeZone)
        case withNetworks([String])
        case withRuntimeGreaterThan(Int)
        case withRuntimeLessThan(Int)
        case includeNullFirstAirDates(Bool)
        case screenedTheatrically(Bool)
        case withStatus([LogicalOperator<TVReleaseStatus>])
        case withType([LogicalOperator<MovieReleaseType>])
    }
}

extension TMDB.Discover.TVFilter: QueryItemEncodable {
    var queryItem: URLQueryItem {
        URLQueryItem(name: key, value: value)
    }

    var key: String {
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
        case .withOriginCountry:
            "with_origin_country"
        case .airDateGreaterThan:
            "air_date.gte"
        case .airDateLessThan:
            "air_date.lte"
        case .firstAirDateGreaterThan:
            "first_air_date.gte"
        case .firstAirDateLessThan:
            "first_air_date.lte"
        case .firstAirDateYear:
            "first_air_date_year"
        case .timezone:
            "timezone"
        case .withNetworks:
            "with_networks"
        case .withRuntimeGreaterThan:
            "with_runtime.gte"
        case .withRuntimeLessThan:
            "with_runtime.lte"
        case .includeNullFirstAirDates:
            "include_null_first_air_dates"
        case .screenedTheatrically:
            "screened_theatrically"
        case .withStatus:
            "with_status"
        case .withType:
            "with_type"
        }
    }

    var value: String {
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
        case .watchRegion(let region):
            region.queryValue
        case .withWatchMonetizationTypes(let types):
            types.queryValue
        case .withoutCompanies(let companies):
            companies.queryValue
        case .withoutGenres(let genres):
            genres.queryValue
        case .withOriginCountry(let country):
            country.queryValue
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
        case .includeNullFirstAirDates(let value):
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
