@_exported public import Dependencies
internal import DependenciesMacros
import Foundation
import TMDB

@DependencyClient
public struct TVEpisodesClient: Sendable {
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season}/episode/{episode}` endpoint
    public var tvEpisodeDetails: @Sendable (
        _ seriesID: Int, _ seasonNumber: Int, _ episodeNumber: Int,
    ) async throws -> TMDB.TVEpisode
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season}/episode/{episode}/credits` endpoint
    public var tvEpisodeCredits: @Sendable (
        _ seriesID: Int, _ seasonNumber: Int, _ episodeNumber: Int,
    ) async throws -> TMDB.MediaCredits
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season}/episode/{episode}/external_ids` endpoint
    public var tvEpisodeExternalIDs: @Sendable (
        _ seriesID: Int, _ seasonNumber: Int, _ episodeNumber: Int,
    ) async throws -> TMDB.ExternalIDs
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season}/episode/{episode}/images` endpoint
    public var tvEpisodeImages: @Sendable (
        _ seriesID: Int, _ seasonNumber: Int, _ episodeNumber: Int,
    ) async throws -> TMDB.ImageCollection
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season}/episode/{episode}/translations` endpoint
    public var tvEpisodeTranslations: @Sendable (
        _ seriesID: Int, _ seasonNumber: Int, _ episodeNumber: Int,
    ) async throws -> [TMDB.Translation]
    /// Make a request to the TMDB API's `/3/tv/{id}/season/{season}/episode/{episode}/videos` endpoint
    public var tvEpisodeVideos: @Sendable (
        _ seriesID: Int, _ seasonNumber: Int, _ episodeNumber: Int,
    ) async throws -> TMDB.VideoCollection
    /// Make a request to the TMDB API's `/3/tv/episode/{episode_id}/changes` endpoint
    public var tvEpisodeChanges: @Sendable (_ episodeID: Int) async throws -> TMDB.ChangeCollection
    /// Make a request to the TMDB API's `/3/tv/episode_group/{id}` endpoint
    public var episodeGroupDetails: @Sendable (_ id: String) async throws -> TMDB.EpisodeGroupDetails
}

public extension DependencyValues {
    /// Dependency that represents the TV episode and episode group TMDB endpoints
    var tmdbTVEpisodes: TVEpisodesClient {
        get { self[TVEpisodesClient.self] }
        set { self[TVEpisodesClient.self] = newValue }
    }
}

extension TVEpisodesClient: DependencyKey {
    public static var liveValue: TVEpisodesClient {
        Self(
            tvEpisodeDetails: {
                try await TMDB.tvEpisodeDetails(seriesID: $0, seasonNumber: $1, episodeNumber: $2)
            },
            tvEpisodeCredits: {
                try await TMDB.tvEpisodeCredits(seriesID: $0, seasonNumber: $1, episodeNumber: $2)
            },
            tvEpisodeExternalIDs: {
                try await TMDB.tvEpisodeExternalIDs(seriesID: $0, seasonNumber: $1, episodeNumber: $2)
            },
            tvEpisodeImages: {
                try await TMDB.tvEpisodeImages(seriesID: $0, seasonNumber: $1, episodeNumber: $2)
            },
            tvEpisodeTranslations: {
                try await TMDB.tvEpisodeTranslations(seriesID: $0, seasonNumber: $1, episodeNumber: $2)
            },
            tvEpisodeVideos: {
                try await TMDB.tvEpisodeVideos(seriesID: $0, seasonNumber: $1, episodeNumber: $2)
            },
            tvEpisodeChanges: {
                try await TMDB.tvEpisodeChanges(episodeID: $0)
            },
            episodeGroupDetails: {
                try await TMDB.episodeGroupDetails(id: $0)
            },
        )
    }
}
