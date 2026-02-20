import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct MovieIntegrationTests {
    @Test func movieDetails() async throws {
        try await withLiveTMDB {
            let movie = try await TMDB.movieDetails(id: 550)
            #expect(movie.id == 550)
            #expect(movie.title == "Fight Club")
        }
    }

    @Test func movieAlternativeTitles() async throws {
        try await withLiveTMDB {
            let titles = try await TMDB.alternativeMovieTitles(id: 550)
            #expect(!titles.isEmpty)
        }
    }

    @Test func movieCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.movieCredits(id: 550)
            #expect(!credits.cast.isEmpty)
            #expect(!credits.crew.isEmpty)
        }
    }

    @Test func movieImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.movieImages(id: 550)
            #expect(!images.backdrops.isEmpty)
        }
    }

    @Test func movieVideos() async throws {
        try await withLiveTMDB {
            let videos = try await TMDB.movieVideos(id: 550)
            #expect(!videos.results.isEmpty)
        }
    }

    @Test func movieReviews() async throws {
        try await withLiveTMDB {
            let reviews = try await TMDB.movieReviews(id: 550)
            #expect(!reviews.results.isEmpty)
        }
    }

    @Test func movieKeywords() async throws {
        try await withLiveTMDB {
            let keywords = try await TMDB.movieKeywords(id: 550)
            #expect(!keywords.isEmpty)
        }
    }

    @Test func similarMovies() async throws {
        try await withLiveTMDB {
            let similar = try await TMDB.similarMovies(id: 550)
            #expect(!similar.results.isEmpty)
        }
    }

    @Test func movieRecommendations() async throws {
        try await withLiveTMDB {
            let recommendations = try await TMDB.movieRecommendations(id: 550)
            #expect(!recommendations.results.isEmpty)
        }
    }

    @Test func movieReleaseDates() async throws {
        try await withLiveTMDB {
            let releaseDates = try await TMDB.movieReleaseDates(id: 550)
            #expect(!releaseDates.isEmpty)
        }
    }

    @Test func movieExternalIDs() async throws {
        try await withLiveTMDB {
            let externalIDs = try await TMDB.movieExternalIDs(id: 550)
            #expect(externalIDs.imdbID != nil)
        }
    }

    @Test func movieTranslations() async throws {
        try await withLiveTMDB {
            let translations = try await TMDB.movieTranslations(id: 550)
            #expect(!translations.isEmpty)
        }
    }

    @Test func movieWatchProviders() async throws {
        try await withLiveTMDB {
            let providers = try await TMDB.movieWatchProviders(id: 550)
            #expect(!providers.results.isEmpty)
        }
    }

    @Test func movieChanges() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.movieChanges(id: 550)
        }
    }

    @Test func latestMovie() async throws {
        try await withLiveTMDB {
            let movie = try await TMDB.latestMovie()
            #expect(movie.id > 0)
        }
    }

    @Test func moviesNowPlaying() async throws {
        try await withLiveTMDB {
            let nowPlaying = try await TMDB.moviesNowPlaying()
            #expect(!nowPlaying.results.isEmpty)
        }
    }

    @Test func popularMovies() async throws {
        try await withLiveTMDB {
            let popular = try await TMDB.popularMovies()
            #expect(!popular.results.isEmpty)
        }
    }

    @Test func topRatedMovies() async throws {
        try await withLiveTMDB {
            let topRated = try await TMDB.topRatedMovies()
            #expect(!topRated.results.isEmpty)
        }
    }

    @Test func upcomingMovies() async throws {
        try await withLiveTMDB {
            let upcoming = try await TMDB.upcomingMovies()
            #expect(!upcoming.results.isEmpty)
        }
    }
}
