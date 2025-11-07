import Foundation

// extension TMDB.Discover.MovieOption: QueryItemEncodable {
//    var encoded: URLQueryItem {
//        switch self {
//        case .language(let payload):
//            URLQueryItem(name: "language", value: payload.queryValue)
//        case .region(let payload):
//            URLQueryItem(name: "region", value: payload.queryValue)
//        case .sortBy(let payload):
//            URLQueryItem(name: "sort_by", value: payload.queryValue)
//        case .certificationCountry(let payload):
//            URLQueryItem(name: "certification_country", value: payload.queryValue)
//        case .certification(let payload):
//            URLQueryItem(name: "certification", value: payload.queryValue)
//        case .certificationLte(let payload):
//            URLQueryItem(name: "certification.lte", value: payload.queryValue)
//        case .certificationGte(let payload):
//            URLQueryItem(name: "certiviation.gte", value: payload.queryValue)
//        case .includeAdult(let payload):
//            URLQueryItem(name: "include_adult", value: payload.queryValue)
//        case .includeVideo(let payload):
//            URLQueryItem(name: "include_video", value: payload.queryValue)
//        case .page(let payload):
//            URLQueryItem(name: "page", value: payload.queryValue)
//        case .primaryReleaseYear(let payload):
//            URLQueryItem(name: "primary_release_year", value: payload.queryValue)
//        case .primaryReleaseDateGte(let payload):
//            URLQueryItem(name: "primary_release_date.gte", value: payload.queryValue)
//        case .primaryReleaseDateLte(let payload):
//            URLQueryItem(name: "primary_release_date.lte", value: payload.queryValue)
//        case .releaseDateGte(let payload):
//            URLQueryItem(name: "release_date.gte", value: payload.queryValue)
//        case .releaseDateLte(let payload):
//            URLQueryItem(name: "release_date.lte", value: payload.queryValue)
//        case .withReleaseType(let payload):
//            URLQueryItem(name: "with_release_type", value: payload.queryValue)
//        case .year(let payload):
//            URLQueryItem(name: "year", value: payload.queryValue)
//        case .voteCountGte(let payload):
//            URLQueryItem(name: "vote_count.gte", value: payload.queryValue)
//        case .voteCountLte(let payload):
//            URLQueryItem(name: "vote_count.lte", value: payload.queryValue)
//        case .voteAverageGte(let payload):
//            URLQueryItem(name: "vote_average.gte", value: payload.queryValue)
//        case .voteAverageLte(let payload):
//            URLQueryItem(name: "vote_average.lte", value: payload.queryValue)
//        case .withCast(let payload):
//            URLQueryItem(name: "with_cast", value: payload.queryValue)
//        case .withCrew(let payload):
//            URLQueryItem(name: "with_crew", value: payload.queryValue)
//        case .withPeople(let payload):
//            URLQueryItem(name: "with_people", value: payload.queryValue)
//        case .withCompanies(let payload):
//            URLQueryItem(name: "with_companies", value: payload.queryValue)
//        case .withoutCompanies(let payload):
//            URLQueryItem(name: "without_companies", value: payload.queryValue)
//        case .withGenres(let payload):
//            URLQueryItem(name: "with_genres", value: payload.queryValue)
//        case .withoutGenres(let payload):
//            URLQueryItem(name: "without_genres", value: payload.queryValue)
//        case .withKeywords(let payload):
//            URLQueryItem(name: "with_keywords", value: payload.queryValue)
//        case .withoutKeywords(let payload):
//            URLQueryItem(name: "without_keywords", value: payload.queryValue)
//        case .withRuntimeGte(let payload):
//            URLQueryItem(name: "with_runtime.gte", value: payload.queryValue)
//        case .withRuntimeLte(let payload):
//            URLQueryItem(name: "with_runtime.lte", value: payload.queryValue)
//        case .withOriginalLanguage(let payload):
//            URLQueryItem(name: "with_original_language", value: payload.queryValue)
//        case .withWatchProviders(let payload):
//            URLQueryItem(name: "with_watch_providers", value: payload.queryValue)
//        case .withWatchMonetizationTypes(let payload):
//            URLQueryItem(name: "with_watch_monetization_types", value: payload.queryValue)
//        case .watchRegion(let payload):
//            URLQueryItem(name: "watch_region", value: payload.map(\.queryValue).queryValue)
//        }
//    }
// }
