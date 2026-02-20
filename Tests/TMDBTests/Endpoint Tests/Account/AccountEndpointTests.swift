import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct AccountEndpointTests {
    // MARK: - Helper

    private func withMockSession(_ operation: () async throws -> Void) async throws {
        try await withDependencies {
            $0.authSessionStore = .init(
                load: {
                    TMDB.AuthSession(
                        accessToken: "mock_access_token",
                        accountID: "mock_account_id",
                        sessionID: "mock_session_id",
                    )
                },
                save: { _ in },
                clear: {},
            )
        } operation: {
            try await operation()
        }
    }

    // MARK: - V4 Account Read Endpoints

    @Test func accountLists() async throws {
        try await withMockSession {
            let result = try await TMDB.accountLists()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 1_234)
            #expect(result.results[0].name == "My Favorites")
        }
    }

    @Test func favoriteMovies() async throws {
        try await withMockSession {
            let result = try await TMDB.favoriteMovies()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 278)
            #expect(result.results[0].title == "The Shawshank Redemption")
        }
    }

    @Test func favoriteTVSeries() async throws {
        try await withMockSession {
            let result = try await TMDB.favoriteTVSeries()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 1_396)
            #expect(result.results[0].name == "Breaking Bad")
        }
    }

    @Test func ratedMovies() async throws {
        try await withMockSession {
            let result = try await TMDB.ratedMovies()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 27_205)
            #expect(result.results[0].accountRating.value == 9.0)
        }
    }

    @Test func ratedTVSeries() async throws {
        try await withMockSession {
            let result = try await TMDB.ratedTVSeries()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 1_399)
            #expect(result.results[0].accountRating.value == 8.5)
        }
    }

    @Test func accountMovieRecommendations() async throws {
        try await withMockSession {
            let result = try await TMDB.accountMovieRecommendations()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 155)
        }
    }

    @Test func accountTVRecommendations() async throws {
        try await withMockSession {
            let result = try await TMDB.accountTVRecommendations()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 1_402)
        }
    }

    @Test func watchlistMovies() async throws {
        try await withMockSession {
            let result = try await TMDB.watchlistMovies()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 157_336)
        }
    }

    @Test func watchlistTVSeries() async throws {
        try await withMockSession {
            let result = try await TMDB.watchlistTVSeries()
            #expect(result.page == 1)
            #expect(!result.results.isEmpty)
            #expect(result.results[0].id == 44_217)
        }
    }

    // MARK: - V3 Account Write Endpoints

    @Test func setFavorite() async throws {
        try await withMockSession {
            let result = try await TMDB.setFavorite(mediaType: .movie, mediaID: 550, favorite: true)
            #expect(result.statusCode == 1)
            #expect(result.statusMessage == "Success.")
        }
    }

    @Test func setWatchlist() async throws {
        try await withMockSession {
            let result = try await TMDB.setWatchlist(mediaType: .movie, mediaID: 550, watchlist: true)
            #expect(result.statusCode == 1)
            #expect(result.statusMessage == "Success.")
        }
    }

    @Test func rateMovie() async throws {
        try await withMockSession {
            let result = try await TMDB.rateMovie(id: 550, rating: 8.5)
            #expect(result.statusCode == 1)
        }
    }

    @Test func deleteMovieRating() async throws {
        try await withMockSession {
            let result = try await TMDB.deleteMovieRating(id: 550)
            #expect(result.statusCode == 1)
        }
    }

    @Test func rateTVSeries() async throws {
        try await withMockSession {
            let result = try await TMDB.rateTVSeries(id: 1_396, rating: 9.0)
            #expect(result.statusCode == 1)
        }
    }

    @Test func deleteTVSeriesRating() async throws {
        try await withMockSession {
            let result = try await TMDB.deleteTVSeriesRating(id: 1_396)
            #expect(result.statusCode == 1)
        }
    }

    @Test func rateTVEpisode() async throws {
        try await withMockSession {
            let result = try await TMDB.rateTVEpisode(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1, rating: 9.0)
            #expect(result.statusCode == 1)
        }
    }

    @Test func deleteTVEpisodeRating() async throws {
        try await withMockSession {
            let result = try await TMDB.deleteTVEpisodeRating(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
            #expect(result.statusCode == 1)
        }
    }

    // MARK: - URL Generation

    @Test func accountListsURL() {
        let endpoint = TMDB.V4Endpoints.Account.lists(accountID: "abc123", page: 1)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/lists")
    }

    @Test func favoriteMoviesURL() {
        let endpoint = TMDB.V4Endpoints.Account.favoriteMovies(
            accountID: "abc123",
            sortBy: .createdAtDescending,
            page: 2,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/movie/favorites")
    }

    @Test func favoriteTVSeriesURL() {
        let endpoint = TMDB.V4Endpoints.Account.favoriteTVSeries(
            accountID: "abc123",
            sortBy: nil,
            page: 1,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/tv/favorites")
    }

    @Test func ratedMoviesURL() {
        let endpoint = TMDB.V4Endpoints.Account.ratedMovies(
            accountID: "abc123",
            sortBy: .createdAtAscending,
            page: 1,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/movie/rated")
    }

    @Test func ratedTVSeriesURL() {
        let endpoint = TMDB.V4Endpoints.Account.ratedTVSeries(
            accountID: "abc123",
            sortBy: nil,
            page: 1,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/tv/rated")
    }

    @Test func movieRecommendationsURL() {
        let endpoint = TMDB.V4Endpoints.Account.movieRecommendations(accountID: "abc123", page: 1, language: nil)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/movie/recommendations")
    }

    @Test func tvRecommendationsURL() {
        let endpoint = TMDB.V4Endpoints.Account.tvRecommendations(accountID: "abc123", page: 1, language: nil)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/tv/recommendations")
    }

    @Test func watchlistMoviesURL() {
        let endpoint = TMDB.V4Endpoints.Account.watchlistMovies(accountID: "abc123", page: 1)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/movie/watchlist")
    }

    @Test func watchlistTVSeriesURL() {
        let endpoint = TMDB.V4Endpoints.Account.watchlistTVSeries(accountID: "abc123", page: 1)
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/4/account/abc123/tv/watchlist")
    }

    @Test func setFavoriteURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.setFavorite(accountID: "12345", sessionID: "sess_abc")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/account/12345/favorite")
    }

    @Test func setWatchlistURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.setWatchlist(accountID: "12345", sessionID: "sess_abc")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/account/12345/watchlist")
    }

    @Test func rateMovieURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.rateMovie(id: 550, sessionID: "sess_abc")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/movie/550/rating")
    }

    @Test func rateTVSeriesURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.rateTVSeries(id: 1_396, sessionID: "sess_abc")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/tv/1396/rating")
    }

    @Test func rateTVEpisodeURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.rateTVEpisode(
            seriesID: 1_396,
            seasonNumber: 1,
            episodeNumber: 3,
            sessionID: "sess_abc",
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/tv/1396/season/1/episode/3/rating")
    }
}
