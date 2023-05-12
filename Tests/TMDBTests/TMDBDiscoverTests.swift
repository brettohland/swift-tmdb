@testable import TMDB
import XCTest

final class TMDBDiscoverTests: XCTestCase {

    func testDiscoverMovieResponseDecoding() throws {
        // Arrange
        let payload = try Utilities.data(inFile: "movie")

        // Act
        let response = try TMDB.decoder.decode(TMDB.Discover.MovieResponse.self, from: payload)
        guard let firstMovie = response.results.first else {
            XCTFail("Decoding resulted in an empty array")
            return
        }

        // Assert
        XCTAssertEqual(response.page, 1)
        XCTAssertEqual(response.totalResults, 61)
        XCTAssertEqual(response.totalPages, 4)
        XCTAssertEqual(response.results.count, 20)

        XCTAssertNil(firstMovie.posterPath)
        XCTAssertFalse(firstMovie.adult)
        XCTAssertNotNil(firstMovie.overview)
        XCTAssertNotNil(firstMovie.releaseDate)
        XCTAssertEqual(firstMovie.genreIds.count, 2)
        XCTAssertEqual(firstMovie.id, 164_558)
        XCTAssertNotNil(firstMovie.originalTitle)
        XCTAssertNotNil(firstMovie.originalLanguage)
        XCTAssertNotNil(firstMovie.title)
        XCTAssertNil(firstMovie.backdropPath)
        XCTAssertNotNil(firstMovie.popularity)
        XCTAssertNotNil(firstMovie.voteCount)
        XCTAssertNotNil(firstMovie.voteAverage)
        XCTAssertFalse(firstMovie.video)
    }

    func testDiscoverTVResponseDecoding() throws {
        // Arrange
        let payload = try Utilities.data(inFile: "tv")

        // Act
        let response = try TMDB.decoder.decode(TMDB.Discover.TVResponse.self, from: payload)
        guard let firstShow = response.results.first else {
            XCTFail("Decoding resulted in an empty array")
            return
        }

        // Assert
        XCTAssertEqual(response.page, 1)
        XCTAssertEqual(response.totalResults, 61_470)
        XCTAssertEqual(response.totalPages, 3_074)
        XCTAssertEqual(response.results.count, 1)
        XCTAssertNotNil(firstShow.posterPath)
        XCTAssertNotNil(firstShow.popularity)
        XCTAssertEqual(firstShow.id, 61_889)
        XCTAssertNil(firstShow.backdropPath)
        XCTAssertNotNil(firstShow.voteAverage)
        XCTAssertNotNil(firstShow.overview)
        XCTAssertNotNil(firstShow.firstAirDate)
        XCTAssertEqual(firstShow.originCountry.count, 1)
        XCTAssertEqual(firstShow.genreIds.count, 1)
        XCTAssertNotNil(firstShow.originalLanguage)
        XCTAssertNotNil(firstShow.voteCount)
        XCTAssertNotNil(firstShow.name)
        XCTAssertNotNil(firstShow.originalName)
        XCTAssertNotNil(firstShow.originalLanguage)
    }

    func testDiscoverFilterQueryEncoding() throws {
        typealias Filter = TMDB.Discover.Filter

        XCTAssertEqual(
            Filter.language(Locale(identifier: "en_US")).encoded.description,
            "language=en_US"
        )
        XCTAssertEqual(
            Filter.sortBy(.popularity(isAscending: true)).encoded.description,
            "sort_option=popularity.asc"
        )
        XCTAssertEqual(
            Filter.sortBy(.popularity(isAscending: false)).encoded.description,
            "sort_option=popularity.desc"
        )
        XCTAssertEqual(
            Filter.sortBy(.averageVote(isAscending: true)).encoded.description,
            "sort_option=average_vote.asc"
        )
        XCTAssertEqual(
            Filter.sortBy(.averageVote(isAscending: false)).encoded.description,
            "sort_option=average_vote.desc"
        )
        XCTAssertEqual(
            Filter.sortBy(.originalTitle(isAscending: true)).encoded.description,
            "sort_option=original_title.asc"
        )
        XCTAssertEqual(
            Filter.sortBy(.originalTitle(isAscending: false)).encoded.description,
            "sort_option=original_title.desc"
        )
        XCTAssertEqual(
            Filter.sortBy(.primaryReleaseDate(isAscending: true)).encoded.description,
            "sort_option=primary_release_date.asc"
        )
        XCTAssertEqual(
            Filter.sortBy(.primaryReleaseDate(isAscending: false)).encoded.description,
            "sort_option=primary_release_date.desc"
        )
        XCTAssertEqual(
            Filter.sortBy(.releaseDate(isAscending: true)).encoded.description,
            "sort_option=release_date.asc"
        )
        XCTAssertEqual(
            Filter.sortBy(.releaseDate(isAscending: false)).encoded.description,
            "sort_option=release_date.desc"
        )
        XCTAssertEqual(
            Filter.sortBy(.revenue(isAscending: true)).encoded.description,
            "sort_option=revenue.asc"
        )
        XCTAssertEqual(
            Filter.sortBy(.revenue(isAscending: false)).encoded.description,
            "sort_option=revenue.desc"
        )
        XCTAssertEqual(
            Filter.sortBy(.voteCount(isAscending: true)).encoded.description,
            "sort_option=vote_count.asc"
        )
        XCTAssertEqual(
            Filter.sortBy(.voteCount(isAscending: false)).encoded.description,
            "sort_option=vote_count.desc"
        )
        XCTAssertEqual(
            Filter.page(1).encoded.description,
            "page=1"
        )
        XCTAssertEqual(
            Filter.voteCountGreaterThan(1).encoded.description,
            "vote_count.gte=1"
        )
        XCTAssertEqual(
            Filter.voteAverageGreaterThan(1.1).encoded.description,
            "vote_average.gte=1.1"
        )
        XCTAssertEqual(
            Filter.withGenres(["a", "b", "c"]).encoded.description,
            "with_genres=a,b,c"
        )
        XCTAssertEqual(
            Filter.withoutGenres(["a", "b", "c"]).encoded.description,
            "without_genres=a,b,c"
        )
        XCTAssertEqual(
            Filter.withOriginalLanguage(Locale(identifier: "en_US")).encoded.description,
            "with_original_language=en_US"
        )
        XCTAssertEqual(
            Filter.withoutKeywords(["a", "b", "c"]).encoded.description,
            "without_keywords=a,b,c"
        )
        XCTAssertEqual(
            Filter.withCompanies(["a", "b", "c"]).encoded.description,
            "with_companies=a,b,c"
        )
        XCTAssertEqual(
            Filter.withKeywords(["a", "b", "c"]).encoded.description,
            "with_keywords=a,b,c"
        )
        XCTAssertEqual(
            Filter.withWatchProviders(.init(filter: .and, list: ["a", "b", "c"])).encoded.description,
            "with_watch_providers=a,b,c"
        )
        XCTAssertEqual(
            Filter.withWatchProviders(.init(filter: .or, list: ["a", "b", "c"])).encoded.description,
            "with_watch_providers=a|b|c"
        )
        XCTAssertEqual(
            Filter.watchRegion([.init(stringLiteral: "us")]).encoded.description,
            "watch_region=us"
        )
        XCTAssertEqual(
            Filter.withWatchMonetizationTypes(["a", "b", "c"]).encoded.description,
            "with_watch_monetization_types=a,b,c"
        )
        XCTAssertEqual(
            Filter.withoutCompanies(.init(filter: .and, list: ["a", "b", "c"])).encoded.description,
            "without_companies=a,b,c"
        )
        XCTAssertEqual(
            Filter.withoutCompanies(.init(filter: .or, list: ["a", "b", "c"])).encoded.description,
            "without_companies=a|b|c"
        )
    }

    func testDiscoverMovieFilterEncoding() throws {
        typealias Filter = TMDB.Discover.MovieFilter

        XCTAssertEqual(
            Filter.region(.init(identifier: "en_US")).encoded.description,
            "region=en_US"
        )

        XCTAssertEqual(
            Filter.voteCountLessThan(1).encoded.description,
            "vote_count.lte=1"
        )

        XCTAssertEqual(
            Filter.voteAverageLessThan(1.1).encoded.description,
            "vote_average.lte=1.1"
        )

        XCTAssertEqual(
            Filter.certificationCountry("a").encoded.description,
            "certification_country=a"
        )

        XCTAssertEqual(
            Filter.certification("a").encoded.description,
            "certification=a"
        )

        XCTAssertEqual(
            Filter.certificationLessThan("a").encoded.description,
            "certification.lte=a"
        )

        XCTAssertEqual(
            Filter.certificationGreaterThan("a").encoded.description,
            "certification.gte=a"
        )

        XCTAssertEqual(
            Filter.includeAdult(true).encoded.description,
            "include_adult=true"
        )

        XCTAssertEqual(
            Filter.includeAdult(false).encoded.description,
            "include_adult=false"
        )

        XCTAssertEqual(
            Filter.includeVideo(true).encoded.description,
            "include_video=true"
        )

        XCTAssertEqual(
            Filter.includeVideo(false).encoded.description,
            "include_video=false"
        )

        XCTAssertEqual(
            Filter.primaryReleaseYear(1_990).encoded.description,
            "primary_release_year=1990"
        )

        var testDateComponents = DateComponents()
        testDateComponents.year = 1_986
        testDateComponents.month = 8
        testDateComponents.day = 8
        let testDate = Calendar(identifier: .gregorian).date(from: testDateComponents)!

        XCTAssertEqual(
            Filter.primaryReleaseDateLessThan(testDate).encoded.description,
            "primary_release_date.lte=1986-08-08"
        )
        XCTAssertEqual(
            Filter.primaryReleaseDateGreaterThan(testDate).encoded.description,
            "primary_release_date.gte=1986-08-08"
        )

        XCTAssertEqual(
            Filter.releaseDateLessThan(testDate).encoded.description,
            "release_date.lte=1986-08-08"
        )

        XCTAssertEqual(
            Filter.releaseDateGreaterThan(testDate).encoded.description,
            "release_date.gte=1986-08-08"
        )

        XCTAssertEqual(
            Filter.withReleaseType(.init(filter: .and, list: ["a", "b", "c"])).encoded.description,
            "with_release_type=a,b,c"
        )

        XCTAssertEqual(
            Filter.withReleaseType(.init(filter: .or, list: ["a", "b", "c"])).encoded.description,
            "with_release_type=a|b|c"
        )

        XCTAssertEqual(Filter.year(1_990).encoded.description, "year=1990")
        XCTAssertEqual(Filter.withCast(["a", "b", "c"]).encoded.description, "with_cast=a,b,c")
        XCTAssertEqual(Filter.withCrew(["a", "b", "c"]).encoded.description, "with_crew=a,b,c")
        XCTAssertEqual(Filter.withPeople(["a", "b", "c"]).encoded.description, "with_people=a,b,c")
        XCTAssertEqual(Filter.withRuntimeLessThan(1).encoded.description, "with_runtime.lte=1")
        XCTAssertEqual(Filter.withRuntimeGreaterThan(1).encoded.description, "with_runtime.gte=1")
    }

    func testDiscoverTVFilterEncoding() throws {
        typealias Filter = TMDB.Discover.TVFilter

        var testDateComponents = DateComponents()
        testDateComponents.year = 1_986
        testDateComponents.month = 8
        testDateComponents.day = 8
        let testDate = Calendar(identifier: .gregorian).date(from: testDateComponents)!

        XCTAssertEqual(
            Filter.airDateLessThan(testDate).encoded.description,
            "air_date.lte=1986-08-08"
        )

        XCTAssertEqual(
            Filter.airDateGreaterThan(testDate).encoded.description,
            "air_date.gte=1986-08-08"
        )

        XCTAssertEqual(
            Filter.firstAirDateYear(1_990).encoded.description,
            "first_air_year=1990"
        )

        XCTAssertEqual(
            Filter.firstAirDateLessThan(testDate).encoded.description,
            "first_air_date.lte=1986-08-08"
        )

        XCTAssertEqual(
            Filter.firstAirDateGreaterThan(testDate).encoded.description,
            "first_air_date.gte=1986-08-08"
        )

        XCTAssertEqual(
            Filter.timezone(.init(abbreviation: "MST")!).encoded.description,
            "timezone=America/Phoenix"
        )

        XCTAssertEqual(Filter.withNetworks(["a", "b", "c"]).encoded.description, "with_networks=a,b,c")
        XCTAssertEqual(Filter.withRuntimeLessThan(1).encoded.description, "with_runtime.lte=1")
        XCTAssertEqual(Filter.withRuntimeGreaterThan(1).encoded.description, "with_runtime.gte=1")
        XCTAssertEqual(Filter.includeNullFirstRunDates(true).encoded.description, "include_null_first_run_dates=true")
        XCTAssertEqual(Filter.includeNullFirstRunDates(false).encoded.description, "include_null_first_run_dates=false")
        XCTAssertEqual(Filter.screenedTheatrically(true).encoded.description, "screened_theatrically=true")
        XCTAssertEqual(Filter.screenedTheatrically(false).encoded.description, "screened_theatrically=false")
        XCTAssertEqual(Filter.withStatus("a").encoded.description, "with_status=a")
        XCTAssertEqual(Filter.withType("a").encoded.description, "with_type=a")
    }
}
