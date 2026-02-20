@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct TVSeasonsClient: Sendable {
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}` endpoint
    public var tvSeasonDetails: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws -> TMDB.TVSeason
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}/credits` endpoint
    public var tvSeasonCredits: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws -> TMDB.MediaCredits
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}/aggregate_credits` endpoint
    public var tvSeasonAggregateCredits: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws
        -> TMDB.AggregateCredits
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}/external_ids` endpoint
    public var tvSeasonExternalIDs: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws -> TMDB.ExternalIDs
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}/images` endpoint
    public var tvSeasonImages: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws -> TMDB.ImageCollection
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}/translations` endpoint
    public var tvSeasonTranslations: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws -> [TMDB.Translation]
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}/videos` endpoint
    public var tvSeasonVideos: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws -> TMDB.VideoCollection
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season_number}/watch/providers` endpoint
    public var tvSeasonWatchProviders: @Sendable (_ seriesID: Int, _ seasonNumber: Int) async throws
        -> TMDB.MediaWatchProviderResult
    /// Make a request to the TMDB API's `/3/tv/season/{season_id}/changes` endpoint
    public var tvSeasonChanges: @Sendable (_ seasonID: Int) async throws -> TMDB.ChangeCollection
}

public extension DependencyValues {
    /// Dependency that represents the `/3/tv/{id}/season` TMDB endpoint
    var tmdbTVSeasons: TVSeasonsClient {
        get { self[TVSeasonsClient.self] }
        set { self[TVSeasonsClient.self] = newValue }
    }
}

extension TVSeasonsClient: DependencyKey {
    public static var liveValue: TVSeasonsClient {
        Self(
            tvSeasonDetails: {
                try await TMDB.tvSeasonDetails(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonCredits: {
                try await TMDB.tvSeasonCredits(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonAggregateCredits: {
                try await TMDB.tvSeasonAggregateCredits(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonExternalIDs: {
                try await TMDB.tvSeasonExternalIDs(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonImages: {
                try await TMDB.tvSeasonImages(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonTranslations: {
                try await TMDB.tvSeasonTranslations(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonVideos: {
                try await TMDB.tvSeasonVideos(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonWatchProviders: {
                try await TMDB.tvSeasonWatchProviders(seriesID: $0, seasonNumber: $1)
            },
            tvSeasonChanges: {
                try await TMDB.tvSeasonChanges(seasonID: $0)
            },
        )
    }
}
