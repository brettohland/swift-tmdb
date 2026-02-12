@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct TVSeriesClient: Sendable {
    /// Make a request to the TMDB API's `/3/tv/{id}` endpoint
    public var tvSeriesDetails: @Sendable (_ id: Int) async throws -> TMDB.TVSeries
    /// Make a request to the TMDB API's `/3/tv/{id}/credits` endpoint
    public var tvSeriesCredits: @Sendable (_ id: Int) async throws -> TMDB.MediaCredits
    /// Make a request to the TMDB API's `/3/tv/{id}/aggregate_credits` endpoint
    public var tvSeriesAggregateCredits: @Sendable (_ id: Int) async throws -> TMDB.AggregateCredits
    /// Make a request to the TMDB API's `/3/tv/{id}/images` endpoint
    public var tvSeriesImages: @Sendable (_ id: Int) async throws -> TMDB.ImageCollection
    /// Make a request to the TMDB API's `/3/tv/{id}/videos` endpoint
    public var tvSeriesVideos: @Sendable (_ id: Int) async throws -> TMDB.VideoCollection
    /// Make a request to the TMDB API's `/3/tv/{id}/reviews` endpoint
    public var tvSeriesReviews: @Sendable (_ id: Int) async throws -> TMDB.Discover.PaginatedResponse<TMDB.Review>
    /// Make a request to the TMDB API's `/3/tv/{id}/keywords` endpoint
    public var tvSeriesKeywords: @Sendable (_ id: Int) async throws -> [TMDB.Keyword]
    /// Make a request to the TMDB API's `/3/tv/{id}/similar` endpoint
    public var similarTVSeries: @Sendable (_ id: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverTV>
    /// Make a request to the TMDB API's `/3/tv/{id}/recommendations` endpoint
    public var tvSeriesRecommendations: @Sendable (_ id: Int) async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverTV>
    /// Make a request to the TMDB API's `/3/tv/{id}/alternative_titles` endpoint
    public var alternativeTVSeriesTitles: @Sendable (_ id: Int) async throws -> [TMDB.AlternativeTitle]
    /// Make a request to the TMDB API's `/3/tv/{id}/content_ratings` endpoint
    public var tvSeriesContentRatings: @Sendable (_ id: Int) async throws -> [TMDB.ContentRating]
    /// Make a request to the TMDB API's `/3/tv/{id}/episode_groups` endpoint
    public var tvSeriesEpisodeGroups: @Sendable (_ id: Int) async throws -> [TMDB.EpisodeGroup]
    /// Make a request to the TMDB API's `/3/tv/{id}/external_ids` endpoint
    public var tvSeriesExternalIDs: @Sendable (_ id: Int) async throws -> TMDB.ExternalIDs
    /// Make a request to the TMDB API's `/3/tv/{id}/translations` endpoint
    public var tvSeriesTranslations: @Sendable (_ id: Int) async throws -> [TMDB.Translation]
    /// Make a request to the TMDB API's `/3/tv/{id}/watch/providers` endpoint
    public var tvSeriesWatchProviders: @Sendable (_ id: Int) async throws -> TMDB.MediaWatchProviderResult
    /// Make a request to the TMDB API's `/3/tv/{id}/screened_theatrically` endpoint
    public var tvSeriesScreenedTheatrically: @Sendable (_ id: Int) async throws -> [TMDB.ScreenedTheatricallyResult]
    /// Make a request to the TMDB API's `/3/tv/{id}/changes` endpoint
    public var tvSeriesChanges: @Sendable (_ id: Int) async throws -> TMDB.ChangeCollection
    /// Make a request to the TMDB API's `/3/tv/latest` endpoint
    public var latestTVSeries: @Sendable () async throws -> TMDB.TVSeries
    /// Make a request to the TMDB API's `/3/tv/airing_today` endpoint
    public var tvSeriesAiringToday: @Sendable () async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverTV>
    /// Make a request to the TMDB API's `/3/tv/on_the_air` endpoint
    public var tvSeriesOnTheAir: @Sendable () async throws -> TMDB.Discover
        .PaginatedResponse<TMDB.Discover.DiscoverTV>
    /// Make a request to the TMDB API's `/3/tv/popular` endpoint
    public var popularTVSeries: @Sendable () async throws -> TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>
    /// Make a request to the TMDB API's `/3/tv/top_rated` endpoint
    public var topRatedTVSeries: @Sendable () async throws -> TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>
}

public extension DependencyValues {
    /// Dependency that represents the `/3/tv` TMDB endpoint
    var tmdbTVSeries: TVSeriesClient {
        get { self[TVSeriesClient.self] }
        set { self[TVSeriesClient.self] = newValue }
    }
}

extension TVSeriesClient: DependencyKey {
    public static var liveValue: TVSeriesClient {
        Self(
            tvSeriesDetails: {
                try await TMDB.tvSeriesDetails(id: $0)
            },
            tvSeriesCredits: {
                try await TMDB.tvSeriesCredits(id: $0)
            },
            tvSeriesAggregateCredits: {
                try await TMDB.tvSeriesAggregateCredits(id: $0)
            },
            tvSeriesImages: {
                try await TMDB.tvSeriesImages(id: $0)
            },
            tvSeriesVideos: {
                try await TMDB.tvSeriesVideos(id: $0)
            },
            tvSeriesReviews: {
                try await TMDB.tvSeriesReviews(id: $0)
            },
            tvSeriesKeywords: {
                try await TMDB.tvSeriesKeywords(id: $0)
            },
            similarTVSeries: {
                try await TMDB.similarTVSeries(id: $0)
            },
            tvSeriesRecommendations: {
                try await TMDB.tvSeriesRecommendations(id: $0)
            },
            alternativeTVSeriesTitles: {
                try await TMDB.alternativeTVSeriesTitles(id: $0)
            },
            tvSeriesContentRatings: {
                try await TMDB.tvSeriesContentRatings(id: $0)
            },
            tvSeriesEpisodeGroups: {
                try await TMDB.tvSeriesEpisodeGroups(id: $0)
            },
            tvSeriesExternalIDs: {
                try await TMDB.tvSeriesExternalIDs(id: $0)
            },
            tvSeriesTranslations: {
                try await TMDB.tvSeriesTranslations(id: $0)
            },
            tvSeriesWatchProviders: {
                try await TMDB.tvSeriesWatchProviders(id: $0)
            },
            tvSeriesScreenedTheatrically: {
                try await TMDB.tvSeriesScreenedTheatrically(id: $0)
            },
            tvSeriesChanges: {
                try await TMDB.tvSeriesChanges(id: $0)
            },
            latestTVSeries: {
                try await TMDB.latestTVSeries()
            },
            tvSeriesAiringToday: {
                try await TMDB.tvSeriesAiringToday()
            },
            tvSeriesOnTheAir: {
                try await TMDB.tvSeriesOnTheAir()
            },
            popularTVSeries: {
                try await TMDB.popularTVSeries()
            },
            topRatedTVSeries: {
                try await TMDB.topRatedTVSeries()
            },
        )
    }
}
