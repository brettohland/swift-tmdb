import Foundation

/// A type that provides a poster image path for URL construction.
///
/// The TMDB API returns image paths as fragments (e.g., `/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg`)
/// rather than complete URLs. Conforming types expose a ``posterPath`` property that can be
/// combined with the cached ``TMDB/imageConfiguration`` to build a fully-qualified image URL.
///
/// Many response types already conform to this protocol, including ``TMDB/Movie``,
/// ``TMDB/TVSeries``, ``TMDB/Collection``, and all discover and search result types
/// that include poster artwork.
///
/// ## Usage
///
/// ```swift
/// let movie = try await TMDB.movieDetails(id: 550)
///
/// if let posterURL = try movie.posterImageURL(size: .setWidth(500)) {
///     // Use posterURL to load the image
/// }
/// ```
///
/// ## Available Sizes
///
/// Use ``TMDB/imageConfiguration`` to inspect ``TMDB/ImageConfiguration/posterSizes``
/// and discover which sizes the API supports. Common poster sizes include `.setWidth(92)`,
/// `.setWidth(154)`, `.setWidth(500)`, and `.original`.
public protocol PosterImageProviding {
    /// The poster image path fragment, e.g. `"/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg"`.
    var posterPath: String? { get }
}

public extension PosterImageProviding {
    /// Constructs a full poster image URL by combining the cached image configuration's
    /// secure base URL, the specified size, and this instance's ``posterPath``.
    ///
    /// - Parameter size: The desired image size (e.g., `.setWidth(500)` or `.original`).
    /// - Returns: A fully-qualified image URL, or `nil` if ``posterPath`` is `nil`.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called, or ``TMDBRequestError/unsupportedImageSize(requested:supported:)`` if
    ///   the size is not in ``TMDB/ImageConfiguration/posterSizes``.
    func posterImageURL(
        size: TMDB.Configuration.ImageSize,
    ) throws(TMDBRequestError) -> URL? {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        guard configuration.posterSizes.contains(size) else {
            throw .unsupportedImageSize(requested: size, supported: configuration.posterSizes)
        }
        guard let posterPath else { return nil }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + posterPath)
    }
}
