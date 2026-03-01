import Foundation

/// A type that provides a generic file-based image path for URL construction.
///
/// The TMDB API returns image paths as fragments (e.g., `/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg`)
/// rather than complete URLs. Unlike the type-specific protocols (``PosterImageProviding``,
/// ``BackdropImageProviding``, etc.), this protocol is for types whose ``filePath`` can
/// represent any image type — poster, backdrop, profile, logo, or still — depending on which
/// collection array they appear in.
///
/// Conforming types include ``TMDB/ImageDetail`` (from ``TMDB/ImageCollection``) and
/// ``TMDB/LogoDetail`` (from ``TMDB/LogoCollection``).
///
/// ## Usage
///
/// ```swift
/// let images = try await TMDB.movieImages(id: 550)
///
/// if let config = TMDB.imageConfiguration {
///     for backdrop in images.backdrops {
///         let url = try backdrop.imageURL(size: .setWidth(780), supportedSizes: config.backdropSizes)
///         // Use url to load the image
///     }
/// }
/// ```
///
/// ## Choosing the Right Size
///
/// Since the image type depends on context, pass the corresponding size array from
/// ``TMDB/imageConfiguration`` as `supportedSizes`:
/// - Posters: ``TMDB/ImageConfiguration/posterSizes``
/// - Backdrops: ``TMDB/ImageConfiguration/backdropSizes``
/// - Profiles: ``TMDB/ImageConfiguration/profileSizes``
/// - Logos: ``TMDB/ImageConfiguration/logoSizes``
/// - Stills: ``TMDB/ImageConfiguration/stillSizes``
public protocol ImageURLProviding {
    /// The image file path fragment, e.g. `"/xRPaJMnQhHPceTGswlhUPsNPGxa.jpg"`.
    var filePath: String { get }
}

public extension ImageURLProviding {
    /// Constructs a full image URL by combining the cached image configuration's secure base URL,
    /// the specified size, and this instance's ``filePath``.
    ///
    /// - Parameters:
    ///   - size: The desired image size (e.g., `.setWidth(500)` or `.original`).
    ///   - supportedSizes: The array of valid sizes for this image type (e.g.,
    ///     ``TMDB/ImageConfiguration/backdropSizes`` for backdrop images).
    /// - Returns: A fully-qualified image URL.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called, or ``TMDBRequestError/unsupportedImageSize(requested:supported:)`` if
    ///   the size is not in `supportedSizes`.
    func imageURL(
        size: TMDB.Configuration.ImageSize,
        supportedSizes: [TMDB.Configuration.ImageSize],
    ) throws(TMDBRequestError) -> URL {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        guard supportedSizes.contains(size) else {
            throw .unsupportedImageSize(requested: size, supported: supportedSizes)
        }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + filePath)!
    }
}
