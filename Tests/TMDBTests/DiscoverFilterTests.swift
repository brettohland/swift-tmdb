import Foundation
import Testing
@testable import TMDB

struct DiscoverFilterTests {
    @Test func verifyMovieFilters() throws {
        typealias MovieFilter = TMDB.Discover.MovieFilter
        let testDate = Date(timeIntervalSince1970: 0)
        let testDateString = "1970-01-01"
        #expect(
            MovieFilter.language(Locale(identifier: "en_US")).queryItem.description == "language=en_US",
        )
        #expect(
            MovieFilter.sortBy(.popularity, .ascending).queryItem.description == "sort_by=popularity.asc",
        )
        #expect(
            MovieFilter.sortBy(.popularity, .descending).queryItem.description == "sort_by=popularity.desc",
        )
        #expect(
            MovieFilter.sortBy(.averageVote, .ascending).queryItem.description == "sort_by=average_vote.asc",
        )
        #expect(
            MovieFilter.sortBy(.averageVote, .descending).queryItem
                .description == "sort_by=average_vote.desc",
        )
        #expect(
            MovieFilter.sortBy(.originalTitle, .ascending).queryItem
                .description == "sort_by=original_title.asc",
        )
        #expect(
            MovieFilter.sortBy(.originalTitle, .descending).queryItem
                .description == "sort_by=original_title.desc",
        )
        #expect(
            MovieFilter.sortBy(.primaryReleaseDate, .ascending).queryItem
                .description == "sort_by=primary_release_date.asc",
        )
        #expect(
            MovieFilter.sortBy(.primaryReleaseDate, .descending).queryItem
                .description == "sort_by=primary_release_date.desc",
        )
        #expect(
            MovieFilter.sortBy(.releaseDate, .ascending).queryItem.description == "sort_by=release_date.asc",
        )
        #expect(
            MovieFilter.sortBy(.releaseDate, .descending).queryItem
                .description == "sort_by=release_date.desc",
        )
        #expect(
            MovieFilter.sortBy(.revenue, .ascending).queryItem.description == "sort_by=revenue.asc",
        )
        #expect(
            MovieFilter.sortBy(.revenue, .descending).queryItem.description == "sort_by=revenue.desc",
        )
        #expect(
            MovieFilter.sortBy(.voteCount, .ascending).queryItem.description == "sort_by=vote_count.asc",
        )
        #expect(
            MovieFilter.sortBy(.voteCount, .descending).queryItem.description == "sort_by=vote_count.desc",
        )
        #expect(
            MovieFilter.page(1).queryItem.description == "page=1",
        )
        #expect(
            MovieFilter.voteCountGreaterThan(1).queryItem.description == "vote_count.gte=1",
        )
        #expect(
            MovieFilter.voteAverageGreaterThan(1.1).queryItem.description == "vote_average.gte=1.1",
        )
        #expect(
            MovieFilter.withGenres([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_genres=a,b,c",
        )
        #expect(
            MovieFilter.withGenres([.and("a"), .or("b")]).queryItem.description == "with_genres=a|b",
        )
        #expect(
            MovieFilter.withoutGenres([.and("a"), .and("b"), .and("c")]).queryItem
                .description == "without_genres=a,b,c",
        )
        #expect(
            MovieFilter.withoutGenres([.and("a"), .or("b")]).queryItem.description == "without_genres=a|b",
        )
        #expect(
            MovieFilter.withOriginalLanguage(Locale.Language(identifier: "en")).queryItem
                .description == "with_original_language=en",
        )
        #expect(
            MovieFilter.withoutKeywords(["a", "b", "c"]).queryItem.description == "without_keywords=a,b,c",
        )
        #expect(
            MovieFilter.withOriginCountry(Locale.Region("us")).queryItem.description == "with_origin_country=us",
        )
        #expect(
            MovieFilter.withCompanies([.and("a"), .and("b"), .and("c")]).queryItem
                .description == "with_companies=a,b,c",
        )
        #expect(
            MovieFilter.withKeywords([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_keywords=a,b,c",
        )
        #expect(
            MovieFilter.withWatchProviders([.and("a"), .and("b"), .and("c")]).queryItem
                .description == "with_watch_providers=a,b,c",
        )
        #expect(
            MovieFilter.withWatchProviders([.and("a"), .or("b")]).queryItem.description == "with_watch_providers=a|b",
        )
        #expect(
            MovieFilter.watchRegion(Locale.Region("us")).queryItem.description == "watch_region=us",
        )
        #expect(
            MovieFilter.withWatchMonetizationTypes(
                [
                    .and(.free),
                    .and(.ads),
                    .and(.flatRate),
                    .and(.rent),
                ],
            ).queryItem.description == "with_watch_monetization_types=free,ads,flatrate,rent",
        )
        #expect(
            MovieFilter.withWatchMonetizationTypes(
                [
                    .and(.free),
                    .and(.ads),
                    .and(.flatRate),
                    .or(.rent),
                ],
            ).queryItem.description == "with_watch_monetization_types=free,ads,flatrate|rent",
        )
        #expect(
            MovieFilter.withoutCompanies(["a", "b", "c"]).queryItem.description == "without_companies=a,b,c",
        )
        #expect(
            MovieFilter.withoutCompanies(["a", "b", "c"]).queryItem.description == "without_companies=a,b,c",
        )
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
            MovieFilter.primaryReleaseDateGreaterThan(testDate).queryItem
                .description == "primary_release_date.gte=\(testDateString)",
        )
        #expect(
            MovieFilter.primaryReleaseDateLessThan(testDate).queryItem
                .description == "primary_release_date.lte=\(testDateString)",
        )
        #expect(
            MovieFilter.primaryReleaseYear(0).queryItem.description == "primary_release_year=0",
        )
        #expect(
            MovieFilter.region(Locale(languageCode: .english, languageRegion: .canada)).queryItem
                .description == "region=en_CA",
        )
        #expect(
            MovieFilter.releaseDateGreaterThan(testDate).queryItem
                .description == "release_date.gte=\(testDateString)",
        )
        #expect(
            MovieFilter.releaseDateLessThan(testDate).queryItem
                .description == "release_date.lte=\(testDateString)",
        )
        #expect(
            MovieFilter.voteCountLessThan(0).queryItem.description == "vote_count.lte=0",
        )
        #expect(
            MovieFilter.voteAverageLessThan(0).queryItem.description == "vote_average.lte=0.0",
        )
        #expect(
            MovieFilter.withCast([.and("a"), .and("b")]).queryItem.description == "with_cast=a,b",
        )
        #expect(
            MovieFilter.withCast([.and("a"), .or("b")]).queryItem.description == "with_cast=a|b",
        )
        #expect(
            MovieFilter.withCrew([.and("a"), .and("b")]).queryItem.description == "with_crew=a,b",
        )
        #expect(
            MovieFilter.withCrew([.and("a"), .or("b")]).queryItem.description == "with_crew=a|b",
        )
        #expect(
            MovieFilter.withPeople([.and("a"), .and("b")]).queryItem.description == "with_people=a,b",
        )
        #expect(
            MovieFilter.withPeople([.and("a"), .or("b")]).queryItem.description == "with_people=a|b",
        )
        #expect(
            MovieFilter.withReleaseType([.and(.premier), .and(.limitedTheatrical)]).queryItem
                .description == "with_release_type=1,2",
        )
        #expect(
            MovieFilter.withReleaseType([.and(.premier), .or(.limitedTheatrical)]).queryItem
                .description == "with_release_type=1|2",
        )
        #expect(
            MovieFilter.withRuntimeGreaterThan(0).queryItem.description == "with_runtime.gte=0",
        )
        #expect(
            MovieFilter.withRuntimeLessThan(0).queryItem.description == "with_runtime.lte=0",
        )
        #expect(
            MovieFilter.year(0).queryItem.description == "year=0",
        )
    }

    @Test func verifyTVFilters() throws {
        typealias TVFilter = TMDB.Discover.TVFilter
        let testDate = Date(timeIntervalSince1970: 0)
        let testDateString = "1970-01-01"
        #expect(
            TVFilter.language(Locale(identifier: "en_US")).queryItem.description == "language=en_US",
        )
        #expect(
            TVFilter.sortBy(.popularity, .ascending).queryItem.description == "sort_by=popularity.asc",
        )
        #expect(
            TVFilter.sortBy(.popularity, .descending).queryItem.description == "sort_by=popularity.desc",
        )
        #expect(
            TVFilter.sortBy(.averageVote, .ascending).queryItem.description == "sort_by=average_vote.asc",
        )
        #expect(
            TVFilter.sortBy(.averageVote, .descending).queryItem.description == "sort_by=average_vote.desc",
        )
        #expect(
            TVFilter.sortBy(.originalTitle, .ascending).queryItem
                .description == "sort_by=original_title.asc",
        )
        #expect(
            TVFilter.sortBy(.originalTitle, .descending).queryItem
                .description == "sort_by=original_title.desc",
        )
        #expect(
            TVFilter.sortBy(.primaryReleaseDate, .ascending).queryItem
                .description == "sort_by=primary_release_date.asc",
        )
        #expect(
            TVFilter.sortBy(.primaryReleaseDate, .descending).queryItem
                .description == "sort_by=primary_release_date.desc",
        )
        #expect(
            TVFilter.sortBy(.releaseDate, .ascending).queryItem.description == "sort_by=release_date.asc",
        )
        #expect(
            TVFilter.sortBy(.releaseDate, .descending).queryItem.description == "sort_by=release_date.desc",
        )
        #expect(
            TVFilter.sortBy(.revenue, .ascending).queryItem.description == "sort_by=revenue.asc",
        )
        #expect(
            TVFilter.sortBy(.revenue, .descending).queryItem.description == "sort_by=revenue.desc",
        )
        #expect(
            TVFilter.sortBy(.voteCount, .ascending).queryItem.description == "sort_by=vote_count.asc",
        )
        #expect(
            TVFilter.sortBy(.voteCount, .descending).queryItem.description == "sort_by=vote_count.desc",
        )
        #expect(
            TVFilter.page(1).queryItem.description == "page=1",
        )
        #expect(
            TVFilter.voteCountGreaterThan(1).queryItem.description == "vote_count.gte=1",
        )
        #expect(
            TVFilter.voteAverageGreaterThan(1.1).queryItem.description == "vote_average.gte=1.1",
        )
        #expect(
            TVFilter.withGenres([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_genres=a,b,c",
        )
        #expect(
            TVFilter.withGenres([.and("a"), .or("b")]).queryItem.description == "with_genres=a|b",
        )
        #expect(
            TVFilter.withoutGenres([.and("a"), .and("b"), .and("c")]).queryItem.description == "without_genres=a,b,c",
        )
        #expect(
            TVFilter.withoutGenres([.and("a"), .or("b")]).queryItem.description == "without_genres=a|b",
        )
        #expect(
            TVFilter.withOriginalLanguage(Locale.Language(identifier: "en")).queryItem
                .description == "with_original_language=en",
        )
        #expect(
            TVFilter.withoutKeywords(["a", "b", "c"]).queryItem.description == "without_keywords=a,b,c",
        )
        #expect(
            TVFilter.withOriginCountry(Locale.Region("us")).queryItem.description == "with_origin_country=us",
        )
        #expect(
            TVFilter.withCompanies([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_companies=a,b,c",
        )
        #expect(
            TVFilter.withKeywords([.and("a"), .and("b"), .and("c")]).queryItem.description == "with_keywords=a,b,c",
        )
        #expect(
            TVFilter.withWatchProviders([.and("a"), .and("b"), .and("c")]).queryItem
                .description == "with_watch_providers=a,b,c",
        )
        #expect(
            TVFilter.withWatchProviders([.and("a"), .or("b")]).queryItem.description == "with_watch_providers=a|b",
        )
        #expect(
            TVFilter.watchRegion(Locale.Region("us")).queryItem.description == "watch_region=us",
        )
        #expect(
            TVFilter.withWatchMonetizationTypes(
                [
                    .and(.free),
                    .and(.ads),
                    .and(.flatRate),
                    .and(.rent),
                ],
            ).queryItem.description == "with_watch_monetization_types=free,ads,flatrate,rent",
        )
        #expect(
            TVFilter.withWatchMonetizationTypes(
                [
                    .and(.free),
                    .and(.ads),
                    .and(.flatRate),
                    .or(.rent),
                ],
            ).queryItem.description == "with_watch_monetization_types=free,ads,flatrate|rent",
        )
        #expect(
            TVFilter.withoutCompanies(["a", "b", "c"]).queryItem.description == "without_companies=a,b,c",
        )
        #expect(
            TVFilter.withoutCompanies(["a", "b", "c"]).queryItem.description == "without_companies=a,b,c",
        )
        #expect(
            TVFilter.airDateGreaterThan(testDate).queryItem.description == "air_date.gte=\(testDateString)",
        )
        #expect(
            TVFilter.airDateLessThan(testDate).queryItem.description == "air_date.lte=\(testDateString)",
        )
        #expect(
            TVFilter.firstAirDateGreaterThan(testDate).queryItem.description == "first_air_date.gte=\(testDateString)",
        )
        #expect(
            TVFilter.firstAirDateLessThan(testDate).queryItem.description == "first_air_date.lte=\(testDateString)",
        )
        #expect(
            TVFilter.firstAirDateYear(0).queryItem.description == "first_air_date_year=0",
        )
        #expect(
            TVFilter.timezone(.gmt).queryItem.description == "timezone=GMT",
        )
        #expect(
            TVFilter.withNetworks(["a", "b"]).queryItem.description == "with_networks=a,b",
        )
        #expect(
            TVFilter.withRuntimeGreaterThan(0).queryItem.description == "with_runtime.gte=0",
        )
        #expect(
            TVFilter.withRuntimeLessThan(0).queryItem.description == "with_runtime.lte=0",
        )
        #expect(
            TVFilter.includeNullFirstAirDates(true).queryItem.description == "include_null_first_air_dates=true",
        )
        #expect(
            TVFilter.includeNullFirstAirDates(false).queryItem.description == "include_null_first_air_dates=false",
        )
        #expect(
            TVFilter.screenedTheatrically(true).queryItem.description == "screened_theatrically=true",
        )
        #expect(
            TVFilter.screenedTheatrically(false).queryItem.description == "screened_theatrically=false",
        )
        #expect(
            TVFilter.withStatus([.and(.returningSeries), .and(.planned)]).queryItem.description == "with_status=0,1",
        )
        #expect(
            TVFilter.withStatus([.and(.returningSeries), .or(.planned)]).queryItem.description == "with_status=0|1",
        )
        #expect(
            TVFilter.withType([.and(.premier), .and(.limitedTheatrical)]).queryItem.description == "with_type=1,2",
        )
        #expect(
            TVFilter.withType([.and(.premier), .or(.limitedTheatrical)]).queryItem.description == "with_type=1|2",
        )
        #expect(
            TVFilter.withStatus([.or(.returningSeries), .and(.planned)]).queryItem.description == "with_status=0,1",
        )
        #expect(
            TVFilter.withStatus([.or(.returningSeries), .or(.planned)]).queryItem.description == "with_status=0|1",
        )
        #expect(
            TVFilter.withType([.or(.premier), .and(.limitedTheatrical)]).queryItem.description == "with_type=1,2",
        )
        #expect(
            TVFilter.withType([.or(.premier), .or(.limitedTheatrical)]).queryItem.description == "with_type=1|2",
        )
    }

}
