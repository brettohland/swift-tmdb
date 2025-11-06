import Foundation
import SharedModels
import Testing
@testable import TMDB

struct DiscoverTests {
    @Test func verifyCommonFilters() throws {
        typealias Filter = TMDBInternal.Discover.Filter
        #expect(
            Filter.language(Locale(identifier: "en_US")).queryItem.description == "language=en_US",
        )
        #expect(
            Filter.sortBy(.popularity(isAscending: true)).queryItem.description == "sort_option=popularity.asc",
        )
        #expect(
            Filter.sortBy(.popularity(isAscending: false)).queryItem.description == "sort_option=popularity.desc",
        )
        #expect(
            Filter.sortBy(.averageVote(isAscending: true)).queryItem.description == "sort_option=average_vote.asc",
        )
        #expect(
            Filter.sortBy(.averageVote(isAscending: false)).queryItem.description == "sort_option=average_vote.desc",
        )
        #expect(
            Filter.sortBy(.originalTitle(isAscending: true)).queryItem.description == "sort_option=original_title.asc",
        )
        #expect(
            Filter.sortBy(.originalTitle(isAscending: false)).queryItem
                .description == "sort_option=original_title.desc",
        )
        #expect(
            Filter.sortBy(.primaryReleaseDate(isAscending: true)).queryItem
                .description == "sort_option=primary_release_date.asc",
        )
        #expect(
            Filter.sortBy(.primaryReleaseDate(isAscending: false)).queryItem
                .description == "sort_option=primary_release_date.desc",
        )
        #expect(
            Filter.sortBy(.releaseDate(isAscending: true)).queryItem.description == "sort_option=release_date.asc",
        )
        #expect(
            Filter.sortBy(.releaseDate(isAscending: false)).queryItem.description == "sort_option=release_date.desc",
        )
        #expect(
            Filter.sortBy(.revenue(isAscending: true)).queryItem.description == "sort_option=revenue.asc",
        )
        #expect(
            Filter.sortBy(.revenue(isAscending: false)).queryItem.description == "sort_option=revenue.desc",
        )
        #expect(
            Filter.sortBy(.voteCount(isAscending: true)).queryItem.description == "sort_option=vote_count.asc",
        )
        #expect(
            Filter.sortBy(.voteCount(isAscending: false)).queryItem.description == "sort_option=vote_count.desc",
        )
        #expect(
            Filter.page(1).queryItem.description == "page=1",
        )
        #expect(
            Filter.voteCountGreaterThan(1).queryItem.description == "vote_count.gte=1",
        )
        #expect(
            Filter.voteAverageGreaterThan(1.1).queryItem.description == "vote_average.gte=1.1",
        )
        #expect(
            Filter.withGenres([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_genres=a,b,c",
        )
        #expect(
            Filter.withGenres([.and("a"), .or("b")]).queryItem.description == "with_genres=a|b",
        )
        #expect(
            Filter.withoutGenres([.and("a"), .and("b"), .and("c")]).queryItem.description == "without_genres=a,b,c",
        )
        #expect(
            Filter.withoutGenres([.and("a"), .or("b")]).queryItem.description == "without_genres=a|b",
        )
        #expect(
            Filter.withOriginalLanguage(Locale.Language(identifier: "en")).queryItem
                .description == "with_original_language=en",
        )
        #expect(
            Filter.withoutKeywords(["a", "b", "c"]).queryItem.description == "without_keywords=a,b,c",
        )
        #expect(
            Filter.withOriginCountry(Locale.Region("us")).queryItem.description == "with_origin_country=us",
        )
        #expect(
            Filter.withCompanies([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_companies=a,b,c",
        )
        #expect(
            Filter.withKeywords([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_keywords=a,b,c",
        )
        #expect(
            Filter.withWatchProviders([.and("a"), .and("b"), .and("c")]).queryItem
                .description == "with_watch_providers=a,b,c",
        )
        #expect(
            Filter.withWatchProviders([.and("a"), .or("b")]).queryItem.description == "with_watch_providers=a|b",
        )
        #expect(
            Filter.watchRegion(Locale.Region("us")).queryItem.description == "watch_region=us",
        )
        #expect(
            Filter.withWatchMonetizationTypes(
                [
                    .and(.free),
                    .and(.ads),
                    .and(.flatRate),
                    .and(.rent),
                ],
            ).queryItem.description == "with_watch_monetization_types=free,ads,flatrate,rent",
        )
        #expect(
            Filter.withWatchMonetizationTypes(
                [
                    .and(.free),
                    .and(.ads),
                    .and(.flatRate),
                    .or(.rent),
                ],
            ).queryItem.description == "with_watch_monetization_types=free,ads,flatrate|rent",
        )
        #expect(
            Filter.withoutCompanies(["a", "b", "c"]).queryItem.description == "without_companies=a,b,c",
        )
        #expect(
            Filter.withoutCompanies(["a", "b", "c"]).queryItem.description == "without_companies=a,b,c",
        )
    }

    @Test func verifyMovieFilters() throws {
        typealias MovieFilter = TMDBInternal.Discover.MovieFilter

        #expect(
            MovieFilter.certification("a").queryItem.description == "certification=a",
        )
        #expect(
            MovieFilter.certificationCountry(Locale.Region("us")).queryItem.description == "certification_country=us",
        )
        #expect(
            MovieFilter.certificationGreaterThan("a").queryItem.description == "certification.gte=a",
        )
        #expect(
            MovieFilter.certificationLessThan("a").queryItem.description == "certification.lte=a",
        )
        #expect(
            MovieFilter.includeAdult(true).queryItem.description == "include_adult=true",
        )
        #expect(
            MovieFilter.includeAdult(false).queryItem.description == "include_adult=false",
        )
        #expect(
            MovieFilter.includeVideo(true).queryItem.description == "include_video=true",
        )
        #expect(
            MovieFilter.includeVideo(false).queryItem.description == "include_video=false",
        )
        #expect(
            MovieFilter.primaryReleaseDateGreaterThan(Date(timeIntervalSince1970: 0)).queryItem
                .description == "primary_release_date.gte=1970-01-01",
        )
    }
}
