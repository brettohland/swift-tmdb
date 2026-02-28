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
/// for backdrop in images.backdrops {
///     if let url = try backdrop.imageURL(size: .setWidth(780)) {
///         // Use url to load the image
///     }
/// }
/// ```
///
/// ## Choosing the Right Size
///
/// Since the image type depends on context, use the corresponding size array from
/// ``TMDB/imageConfiguration``:
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
    /// - Parameter size: The desired image size (e.g., `.setWidth(500)` or `.original`).
    /// - Returns: A fully-qualified image URL.
    /// - Throws: ``TMDBRequestError/imageConfigurationMissing`` if ``TMDB/initialize(configuration:)``
    ///   has not been called.
    func imageURL(
        size: TMDB.Configuration.ImageSize,
    ) throws(TMDBRequestError) -> URL {
        guard let configuration = TMDB.imageConfiguration else {
            throw .imageConfigurationMissing
        }
        return URL(string: configuration.secureBaseUrl.absoluteString + size.rawValue + filePath)!
    }
}
