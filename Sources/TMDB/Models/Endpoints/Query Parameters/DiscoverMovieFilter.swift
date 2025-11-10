import Foundation

extension TMDB.Discover {
    enum MovieFilter {

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

        // Movie filters
        case certification(String)
        case certificationCountry(Locale.Region)
        case certificationGreaterThan(String)
        case certificationLessThan(String)
        case includeAdult(Bool)
        case includeVideo(Bool)
        case primaryReleaseDateGreaterThan(Date)
        case primaryReleaseDateLessThan(Date)
        case primaryReleaseYear(Int)
        case region(Locale)
        case releaseDateGreaterThan(Date)
        case releaseDateLessThan(Date)
        case voteAverageLessThan(Double)
        case voteCountLessThan(Int)
        case withCast([LogicalOperator<String>])
        case withCrew([LogicalOperator<String>])
        case withPeople([LogicalOperator<String>])
        case withReleaseType([LogicalOperator<MovieReleaseType>])
        case withRuntimeGreaterThan(Int)
        case withRuntimeLessThan(Int)
        case year(Int)
    }
}

extension TMDB.Discover.MovieFilter: QueryItemEncodable {
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
            value.map(\.description).queryValue
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
