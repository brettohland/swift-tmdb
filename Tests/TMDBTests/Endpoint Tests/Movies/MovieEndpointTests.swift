import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct MovieEndpointTests {
    @Test func movieDetails() async throws {
        _ = try await TMDB.movieDetails(id: 0)
    }

    @Test func movieAlternativeTitles() async throws {
        _ = try await TMDB.alternativeMovieTitles(id: 550)
    }

    @Test func movieAlternativeTitlesForMovie() async throws {
        let movie = try TMDB.Movie.mock()
        _ = try await TMDB.alternativeMovieTitles(movie: movie)
    }

    @Test func movieCredits() async throws {
        let credits = try await TMDB.movieCredits(id: 550)
        #expect(!credits.cast.isEmpty)
        #expect(!credits.crew.isEmpty)
    }

    @Test func movieImages() async throws {
        let images = try await TMDB.movieImages(id: 550)
        #expect(!images.backdrops.isEmpty)
    }

    @Test func movieVideos() async throws {
        let videos = try await TMDB.movieVideos(id: 550)
        #expect(!videos.results.isEmpty)
    }

    @Test func movieReviews() async throws {
        let reviews = try await TMDB.movieReviews(id: 550)
        #expect(!reviews.results.isEmpty)
    }

    @Test func movieKeywords() async throws {
        let keywords = try await TMDB.movieKeywords(id: 550)
        #expect(!keywords.isEmpty)
    }

    @Test func similarMovies() async throws {
        let similar = try await TMDB.similarMovies(id: 550)
        #expect(!similar.results.isEmpty)
    }

    @Test func movieRecommendations() async throws {
        let recommendations = try await TMDB.movieRecommendations(id: 550)
        #expect(!recommendations.results.isEmpty)
    }

    @Test func movieReleaseDates() async throws {
        let releaseDates = try await TMDB.movieReleaseDates(id: 550)
        #expect(!releaseDates.isEmpty)
    }

    @Test func movieExternalIDs() async throws {
        let externalIDs = try await TMDB.movieExternalIDs(id: 550)
        #expect(externalIDs.imdbID != nil)
    }

    @Test func movieTranslations() async throws {
        let translations = try await TMDB.movieTranslations(id: 550)
        #expect(!translations.isEmpty)
    }

    @Test func movieWatchProviders() async throws {
        let providers = try await TMDB.movieWatchProviders(id: 550)
        #expect(!providers.results.isEmpty)
    }

    @Test func movieChanges() async throws {
        let changes = try await TMDB.movieChanges(id: 550)
        #expect(!changes.changes.isEmpty)
    }

    @Test func latestMovie() async throws {
        let movie = try await TMDB.latestMovie()
        #expect(!movie.title.isEmpty)
    }

    @Test func moviesNowPlaying() async throws {
        let nowPlaying = try await TMDB.moviesNowPlaying()
        #expect(!nowPlaying.results.isEmpty)
    }

    @Test func popularMovies() async throws {
        let popular = try await TMDB.popularMovies()
        #expect(!popular.results.isEmpty)
    }

    @Test func topRatedMovies() async throws {
        let topRated = try await TMDB.topRatedMovies()
        #expect(!topRated.results.isEmpty)
    }

    @Test func upcomingMovies() async throws {
        let upcoming = try await TMDB.upcomingMovies()
        #expect(!upcoming.results.isEmpty)
    }
}
