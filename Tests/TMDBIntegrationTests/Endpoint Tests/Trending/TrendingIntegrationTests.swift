import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct TrendingIntegrationTests {
    @Test func trendingAllDay() async throws {
        try await withLiveTMDB {
            let trending = try await TMDB.trendingAll(timeWindow: .day)
            #expect(!trending.results.isEmpty)
        }
    }

    @Test func trendingAllWeek() async throws {
        try await withLiveTMDB {
            let trending = try await TMDB.trendingAll(timeWindow: .week)
            #expect(!trending.results.isEmpty)
        }
    }

    @Test func trendingMoviesDay() async throws {
        try await withLiveTMDB {
            let trending = try await TMDB.trendingMovies(timeWindow: .day)
            #expect(!trending.results.isEmpty)
        }
    }

    @Test func trendingTVDay() async throws {
        try await withLiveTMDB {
            let trending = try await TMDB.trendingTV(timeWindow: .day)
            #expect(!trending.results.isEmpty)
        }
    }

    @Test func trendingPeopleDay() async throws {
        try await withLiveTMDB {
            let trending = try await TMDB.trendingPeople(timeWindow: .day)
            #expect(!trending.results.isEmpty)
        }
    }
}
