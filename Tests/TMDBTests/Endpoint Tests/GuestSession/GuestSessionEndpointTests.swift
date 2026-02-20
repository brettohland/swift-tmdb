import Foundation
import Testing
@testable import TMDB

struct GuestSessionEndpointTests {
    // MARK: - Read Endpoints

    @Test func createGuestSession() async throws {
        let result = try await TMDB.createGuestSession()
        #expect(result.isSuccess)
        #expect(!result.guestSessionID.isEmpty)
        #expect(!result.expiresAt.isEmpty)
    }

    @Test func guestRatedMovies() async throws {
        let result = try await TMDB.guestRatedMovies(sessionID: "abc123")
        #expect(result.page == 1)
        #expect(!result.results.isEmpty)
        #expect(result.results[0].id == 278)
        #expect(result.results[0].title == "The Shawshank Redemption")
        #expect(result.results[0].rating == 9.0)
    }

    @Test func guestRatedTV() async throws {
        let result = try await TMDB.guestRatedTV(sessionID: "abc123")
        #expect(result.page == 1)
        #expect(!result.results.isEmpty)
        #expect(result.results[0].id == 1_396)
        #expect(result.results[0].name == "Breaking Bad")
        #expect(result.results[0].rating == 8.5)
    }

    @Test func guestRatedEpisodes() async throws {
        let result = try await TMDB.guestRatedEpisodes(sessionID: "abc123")
        #expect(result.page == 1)
        #expect(!result.results.isEmpty)
        #expect(result.results[0].id == 62_161)
        #expect(result.results[0].episodeNumber == 16)
        #expect(result.results[0].seasonNumber == 5)
        #expect(result.results[0].showID == 1_396)
        #expect(result.results[0].rating == 10.0)
    }

    // MARK: - Guest Write Endpoints

    @Test func guestRateMovie() async throws {
        let result = try await TMDB.guestRateMovie(id: 550, rating: 8.5, guestSessionID: "abc123")
        #expect(result.statusCode == 1)
    }

    @Test func guestDeleteMovieRating() async throws {
        let result = try await TMDB.guestDeleteMovieRating(id: 550, guestSessionID: "abc123")
        #expect(result.statusCode == 1)
    }

    @Test func guestRateTVSeries() async throws {
        let result = try await TMDB.guestRateTVSeries(id: 1_396, rating: 9.0, guestSessionID: "abc123")
        #expect(result.statusCode == 1)
    }

    @Test func guestDeleteTVSeriesRating() async throws {
        let result = try await TMDB.guestDeleteTVSeriesRating(id: 1_396, guestSessionID: "abc123")
        #expect(result.statusCode == 1)
    }

    @Test func guestRateTVEpisode() async throws {
        let result = try await TMDB.guestRateTVEpisode(
            seriesID: 1_396,
            seasonNumber: 5,
            episodeNumber: 16,
            rating: 10.0,
            guestSessionID: "abc123",
        )
        #expect(result.statusCode == 1)
    }

    @Test func guestDeleteTVEpisodeRating() async throws {
        let result = try await TMDB.guestDeleteTVEpisodeRating(
            seriesID: 1_396,
            seasonNumber: 5,
            episodeNumber: 16,
            guestSessionID: "abc123",
        )
        #expect(result.statusCode == 1)
    }

    // MARK: - URL Generation

    @Test func createGuestSessionURL() {
        let endpoint = TMDB.V3Endpoints.GuestSession.create
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/authentication/guest_session/new")
    }

    @Test func guestRatedMoviesURL() {
        let endpoint = TMDB.V3Endpoints.GuestSession.ratedMovies(
            guestSessionID: "abc123",
            sortBy: nil,
            page: 1,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/guest_session/abc123/rated/movies")
    }

    @Test func guestRatedTVURL() {
        let endpoint = TMDB.V3Endpoints.GuestSession.ratedTV(
            guestSessionID: "abc123",
            sortBy: .createdAtDescending,
            page: 2,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/guest_session/abc123/rated/tv")
    }

    @Test func guestRatedEpisodesURL() {
        let endpoint = TMDB.V3Endpoints.GuestSession.ratedEpisodes(
            guestSessionID: "abc123",
            sortBy: nil,
            page: 1,
            language: nil,
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/guest_session/abc123/rated/tv/episodes")
    }

    @Test func guestRateMovieURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.guestRateMovie(id: 550, guestSessionID: "guest_abc")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/movie/550/rating")
        #expect(url.absoluteString.contains("guest_session_id=guest_abc"))
    }

    @Test func guestRateTVSeriesURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.guestRateTVSeries(id: 1_396, guestSessionID: "guest_abc")
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/tv/1396/rating")
        #expect(url.absoluteString.contains("guest_session_id=guest_abc"))
    }

    @Test func guestRateTVEpisodeURL() {
        let endpoint = TMDB.V3Endpoints.AccountWrite.guestRateTVEpisode(
            seriesID: 1_396,
            seasonNumber: 5,
            episodeNumber: 16,
            guestSessionID: "guest_abc",
        )
        let url = endpoint.makeURL(baseURL: TMDB.Constants.baseURL)
        #expect(url.relativePath == "/3/tv/1396/season/5/episode/16/rating")
        #expect(url.absoluteString.contains("guest_session_id=guest_abc"))
    }
}
