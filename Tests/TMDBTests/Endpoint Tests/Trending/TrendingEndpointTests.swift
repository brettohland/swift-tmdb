import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct TrendingEndpointTests {
    init() { TMDBMockData.register() }
    @Test func trendingAllDay() async throws {
        let trending = try await TMDB.trendingAll(timeWindow: .day)
        #expect(!trending.results.isEmpty)
    }

    @Test func trendingAllWeek() async throws {
        let trending = try await TMDB.trendingAll(timeWindow: .week)
        #expect(!trending.results.isEmpty)
    }

    @Test func trendingMoviesDay() async throws {
        let trending = try await TMDB.trendingMovies(timeWindow: .day)
        #expect(!trending.results.isEmpty)
    }

    @Test func trendingMoviesWeek() async throws {
        let trending = try await TMDB.trendingMovies(timeWindow: .week)
        #expect(!trending.results.isEmpty)
    }

    @Test func trendingTVDay() async throws {
        let trending = try await TMDB.trendingTV(timeWindow: .day)
        #expect(!trending.results.isEmpty)
    }

    @Test func trendingTVWeek() async throws {
        let trending = try await TMDB.trendingTV(timeWindow: .week)
        #expect(!trending.results.isEmpty)
    }

    @Test func trendingPeopleDay() async throws {
        let trending = try await TMDB.trendingPeople(timeWindow: .day)
        #expect(!trending.results.isEmpty)
    }

    @Test func trendingPeopleWeek() async throws {
        let trending = try await TMDB.trendingPeople(timeWindow: .week)
        #expect(!trending.results.isEmpty)
    }
}
