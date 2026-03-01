import Foundation

/// A type that provides a still image path for URL construction.
///
/// The TMDB API returns image paths as fragments (e.g., `/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg`)
/// rather than complete URLs. Conforming types expose a ``stillPath`` property that can be
/// combined with the cached ``TMDB/imageConfiguration`` to build a fully-qualified image URL.
///
/// Still images are typically screenshots from TV episodes. Conforming types include
/// ``TMDB/TVEpisode``, ``TMDB/GuestSession/RatedEpisode``,
/// ``TMDB/TVSeries/EpisodeOverview``, and ``TMDB/FindTVEpisode``.
///
/// ## Usage
///
/// ```swift
/// let episode = try await TMDB.tvEpisodeDetails(
///     seriesID: 1396, seasonNumber: 1, episodeNumber: 1
/// )
///
/// if let stillURL = try episode.stillImageURL(size: .setWidth(300)) {
///     // Use stillURL to load the image
/// }
/// ```
///
/// ## Available Sizes
///
/// Use ``TMDB/imageConfiguration`` to inspect ``TMDB/ImageConfiguration/stillSizes``
/// and discover which sizes the API supports. Common still sizes include `.setWidth(92)`,
/// `.setWidth(185)`, `.setWidth(300)`, and `.original`.
public protocol StillImageProviding {
    /// The still image path fragment, e.g. `"/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg"`.
    var stillPath: String? { get }
}

public extension StillImageProviding {
    /// Constructs a full still image URL by combining the cached image configuration's
    /// secure base URL, the specified size, and this instance's ``stillPath``.
    ///
    /// - Parameter size: The desired image size (e.g., `.setWidth(300)` or `.original`).
    /// - Returns: A fully-qualified image URL, or `nil` if ``stillPath`` is `nil`.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called, or ``TMDBRequestError/unsupportedImageSize(requested:supported:)`` if
    ///   the size is not in ``TMDB/ImageConfiguration/stillSizes``.
    func stillImageURL(
        size: TMDB.Configuration.ImageSize,
    ) throws(TMDBRequestError) -> URL? {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        guard configuration.stillSizes.contains(size) else {
            throw .unsupportedImageSize(requested: size, supported: configuration.stillSizes)
        }
        guard let stillPath else { return nil }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + stillPath)
    }
}
