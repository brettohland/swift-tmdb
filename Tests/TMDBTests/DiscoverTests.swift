import Foundation
import Testing
import SharedModels
@testable import TMDB

struct DiscoverTests {
    @Test func verifyDiscoverMovieDecoding() throws {
        // Arrange
//        let htmlBody = try TestUtilities.jsonDataFromFile("movie")

        // Act/Assert
//        _ = try TMDB.decoder.decode(TMDB.Discover.MovieResponse.self, from: htmlBody)
    }

    @Test func verifyDiscoverTVDecoding() throws {
        // Arrange
//        let htmlBody = try TestUtilities.jsonDataFromFile("tv")

        // Act/Assert
//        _ = try TMDB.decoder.decode(TMDB.Discover.TVResponse.self, from: htmlBody)
    }

    @Test func discoverTMDBDiscoverFilterQuery() throws {
        #expect(
            TMDBInternal.Discover.Filter.language(Locale(identifier: "en_US")).queryItem.description == "language=en_US",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.popularity(isAscending: true)).queryItem
                .description == "sort_option=popularity.asc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.popularity(isAscending: false)).queryItem
                .description == "sort_option=popularity.desc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.averageVote(isAscending: true)).queryItem
                .description == "sort_option=average_vote.asc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.averageVote(isAscending: false)).queryItem
                .description == "sort_option=average_vote.desc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.originalTitle(isAscending: true)).queryItem
                .description == "sort_option=original_title.asc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.originalTitle(isAscending: false)).queryItem
                .description == "sort_option=original_title.desc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.primaryReleaseDate(isAscending: true)).queryItem
                .description == "sort_option=primary_release_date.asc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.primaryReleaseDate(isAscending: false)).queryItem
                .description == "sort_option=primary_release_date.desc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.releaseDate(isAscending: true)).queryItem
                .description == "sort_option=release_date.asc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.releaseDate(isAscending: false)).queryItem
                .description == "sort_option=release_date.desc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.revenue(isAscending: true)).queryItem.description == "sort_option=revenue.asc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.revenue(
                isAscending: false,
            )).queryItem.description == "sort_option=revenue.desc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.voteCount(isAscending: true)).queryItem
                .description == "sort_option=vote_count.asc",
        )
        #expect(
            TMDBInternal.Discover.Filter.sortBy(.voteCount(isAscending: false)).queryItem
                .description == "sort_option=vote_count.desc",
        )
        #expect(
            TMDBInternal.Discover.Filter.page(1).queryItem.description ==
                "page=1",
        )
        #expect(
            TMDBInternal.Discover.Filter.voteCountGreaterThan(1).queryItem.description == "vote_count.gte=1",
        )
        #expect(
            TMDBInternal.Discover.Filter.voteAverageGreaterThan(1.1).queryItem.description == "vote_average.gte=1.1",
        )
        #expect(
            TMDBInternal.Discover.Filter.withGenres(["a", "b", "c"]).queryItem.description == "with_genres=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withoutGenres(["a", "b", "c"]).queryItem.description == "without_genres=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withOriginalLanguage(Locale(identifier: "en_US")).queryItem
                .description == "with_original_language=en_US",
        )
        #expect(
            TMDBInternal.Discover.Filter.withoutKeywords(["a", "b", "c"]).queryItem.description == "without_keywords=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withCompanies(["a", "b", "c"]).queryItem.description == "with_companies=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withKeywords(["a", "b", "c"]).queryItem.description == "with_keywords=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withWatchProviders(.init(filter: .and, list: ["a", "b", "c"])).queryItem
                .description == "with_watch_providers=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withWatchProviders(.init(filter: .or, list: ["a", "b", "c"])).queryItem
                .description == "with_watch_providers=a|b|c",
        )
        #expect(
            TMDBInternal.Discover.Filter.watchRegion([.init(stringLiteral: "us")]).queryItem.description == "watch_region=us",
        )
        #expect(
            TMDBInternal.Discover.Filter.withWatchMonetizationTypes(["a", "b", "c"]).queryItem
                .description == "with_watch_monetization_types=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withoutCompanies(.init(filter: .and, list: ["a", "b", "c"])).queryItem
                .description == "without_companies=a,b,c",
        )
        #expect(
            TMDBInternal.Discover.Filter.withoutCompanies(.init(filter: .or, list: ["a", "b", "c"])).queryItem
                .description == "without_companies=a|b|c",
        )
    }
}
