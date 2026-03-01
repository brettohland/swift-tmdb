import Foundation

/// A type that provides a backdrop image path for URL construction.
///
/// The TMDB API returns image paths as fragments (e.g., `/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg`)
/// rather than complete URLs. Conforming types expose a ``backdropPath`` property that can be
/// combined with the cached ``TMDB/imageConfiguration`` to build a fully-qualified image URL.
///
/// All types that conform to `BackdropImageProviding` also conform to ``PosterImageProviding``,
/// since TMDB response types that include backdrop artwork always include poster artwork as well.
///
/// ## Usage
///
/// ```swift
/// let movie = try await TMDB.movieDetails(id: 550)
///
/// if let backdropURL = try movie.backdropImageURL(size: .setWidth(780)) {
///     // Use backdropURL to load the image
/// }
/// ```
///
/// ## Available Sizes
///
/// Use ``TMDB/imageConfiguration`` to inspect ``TMDB/ImageConfiguration/backdropSizes``
/// and discover which sizes the API supports. Common backdrop sizes include `.setWidth(300)`,
/// `.setWidth(780)`, and `.original`.
public protocol BackdropImageProviding {
    /// The backdrop image path fragment, e.g. `"/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg"`.
    var backdropPath: String? { get }
}

public extension BackdropImageProviding {
    /// Constructs a full backdrop image URL by combining the cached image configuration's
    /// secure base URL, the specified size, and this instance's ``backdropPath``.
    ///
    /// - Parameter size: The desired image size (e.g., `.setWidth(780)` or `.original`).
    /// - Returns: A fully-qualified image URL, or `nil` if ``backdropPath`` is `nil`.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called, or ``TMDBRequestError/unsupportedImageSize(requested:supported:)`` if
    ///   the size is not in ``TMDB/ImageConfiguration/backdropSizes``.
    func backdropImageURL(
        size: TMDB.Configuration.ImageSize,
    ) throws(TMDBRequestError) -> URL? {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        guard configuration.backdropSizes.contains(size) else {
            throw .unsupportedImageSize(requested: size, supported: configuration.backdropSizes)
        }
        guard let backdropPath else { return nil }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + backdropPath)
    }
}
