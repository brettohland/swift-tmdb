import Foundation
import Testing
@testable import TMDB

struct EndpointFactoryTests {
    @Test func verifyConfigurationURLFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Configuration.details,
            againstPattern: "^/3/configuration$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Configuration.details,
                againstPattern: "^/3/configuration/countries$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Configuration.countries,
            againstPattern: "^/3/configuration/countries$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Configuration.countries,
                againstPattern: "^/3/configuration$",
            )
        }
    }

    @Test func verifyDiscoverFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Discover.movie(filters: []),
            againstPattern: "^/3/discover/movie$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Discover.movie(filters: []),
                againstPattern: "^/3/discover/tv$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Discover.tv(filters: []),
            againstPattern: "^/3/discover/tv$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Discover.tv(filters: []),
                againstPattern: "^/3/discover/movie$",
            )
        }
    }

    @Test func verifyMovieFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.Movies.details(id: 0, language: Locale?.none),
            againstPattern: "^/3/movie/\\d+$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Movies.details(id: 0, language: Locale?.none),
                againstPattern: "^/3/movie/\\d+/alternative_titles$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
            againstPattern: "^/3/movie/\\d+/alternative_titles$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.Movies.alternativeTitles(id: 0),
                againstPattern: "^/3/movie/\\d+$",
            )
        }
    }

    @Test func verifyTVSeriesFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.TVSeries.details(id: 0, language: Locale?.none),
            againstPattern: "^/3/tv/\\d+$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.TVSeries.details(id: 0, language: Locale?.none),
                againstPattern: "^/3/tv/\\d+/credits$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.TVSeries.credits(id: 0, language: Locale?.none),
            againstPattern: "^/3/tv/\\d+/credits$",
        )
        try checkURLFactory(
            TMDB.V3Endpoints.TVSeries.popular(page: 1, language: Locale?.none, region: Locale.Region?.none),
            againstPattern: "^/3/tv/popular$",
        )
        try checkURLFactory(
            TMDB.V3Endpoints.TVSeries.changes(id: 0, startDate: nil, endDate: nil, page: 1),
            againstPattern: "^/3/tv/\\d+/changes$",
        )
    }

    @Test func verifyTVSeasonFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.TVSeasons.details(seriesID: 0, seasonNumber: 1, language: Locale?.none),
            againstPattern: "^/3/tv/\\d+/season/\\d+$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.TVSeasons.details(seriesID: 0, seasonNumber: 1, language: Locale?.none),
                againstPattern: "^/3/tv/\\d+/season/\\d+/credits$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.TVSeasons.changes(seasonID: 0, startDate: nil, endDate: nil, page: 1),
            againstPattern: "^/3/tv/season/\\d+/changes$",
        )
    }

    @Test func verifyTVEpisodeFactories() throws {
        try checkURLFactory(
            TMDB.V3Endpoints.TVEpisodes.details(
                seriesID: 0,
                seasonNumber: 1,
                episodeNumber: 1,
                language: Locale?.none,
            ),
            againstPattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+$",
        )
        #expect(throws: URLError.self) {
            try checkURLFactory(
                TMDB.V3Endpoints.TVEpisodes.details(
                    seriesID: 0,
                    seasonNumber: 1,
                    episodeNumber: 1,
                    language: Locale?.none,
                ),
                againstPattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+/credits$",
            )
        }
        try checkURLFactory(
            TMDB.V3Endpoints.TVEpisodes.changes(episodeID: 0, startDate: nil, endDate: nil, page: 1),
            againstPattern: "^/3/tv/episode/\\d+/changes$",
        )
    }
}

extension EndpointFactoryTests {
    func checkURLFactory(_ factory: any EndpointFactory, againstPattern pattern: String) throws {
        let url = factory.makeURL(baseURL: TMDB.Constants.baseURL)
        let regex = try Regex(pattern)
        guard url.relativePath.contains(regex) else {
            throw URLError(.badURL)
        }
    }
}
